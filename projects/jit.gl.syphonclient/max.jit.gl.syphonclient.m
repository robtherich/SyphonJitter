/*
    max.jit.gl.syphonclient.m
    jit.gl.syphonclient
	
    Copyright 2010 bangnoise (Tom Butterworth) & vade (Anton Marini).
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "jit.common.h"
#include "jit.glext_nv.h"
#include "jit.gl.h"

#import "Syphon.h"

typedef struct _max_jit_gl_syphon_client 
{
	t_object		ob;
	void			*obex;
	
	// output texture outlet
	void			*texout;
    void            *dumpout;
    
} t_max_jit_gl_syphon_client;

t_jit_err jit_gl_syphon_client_init(void); 

void *max_jit_gl_syphon_client_new(t_symbol *s, long argc, t_atom *argv);
void max_jit_gl_syphon_client_free(t_max_jit_gl_syphon_client *x);

// custom draw
void max_jit_gl_syphon_client_bang(t_max_jit_gl_syphon_client *x);
void max_jit_gl_syphon_client_draw(t_max_jit_gl_syphon_client *x, t_symbol *s, long argc, t_atom *argv);

//custom list outof available servers via the dumpout outlet.
void max_jit_gl_syphon_client_getavailableservers(t_max_jit_gl_syphon_client *x);

t_class *max_jit_gl_syphon_client_class;

t_symbol *ps_jit_gl_texture,*ps_draw,*ps_out_name, *ps_appname, *ps_servername, *ps_clear;

int C74_EXPORT main(void)
{	
	t_class *maxclass, *jitclass;

	jit_gl_syphon_client_init();

	maxclass = class_new("jit.gl.syphonclient", (method)max_jit_gl_syphon_client_new, (method)max_jit_gl_syphon_client_free, sizeof(t_max_jit_gl_syphon_client), NULL, A_GIMME, 0);
	max_jit_class_obex_setup(maxclass, calcoffset(t_max_jit_gl_syphon_client, obex));
	jitclass = jit_class_findbyname(gensym("jit_gl_syphon_client"));

	max_jit_class_wrap_standard(maxclass, jitclass, 0);
	max_jit_class_ob3d_wrap(maxclass);

	// custom draw handler so we can output our texture.
	// override default ob3d bang/draw methods
	class_addmethod(maxclass, (method)max_jit_gl_syphon_client_bang, "bang", 0);
	max_jit_class_addmethod_defer_low(maxclass, (method)max_jit_gl_syphon_client_draw, "draw");
	max_jit_class_addmethod_defer_low(maxclass, (method)max_jit_gl_syphon_client_getavailableservers, "getavailableservers");

	class_addmethod(maxclass, (method)max_jit_ob3d_assist, "assist", A_CANT, 0);

	class_register(CLASS_BOX, maxclass);
	max_jit_gl_syphon_client_class = maxclass;
	
	ps_jit_gl_texture = gensym("jit_gl_texture");
	ps_draw = gensym("draw");
	ps_out_name = gensym("out_name");
	ps_servername = gensym("servername");
	ps_appname = gensym("appname");
	ps_clear = gensym("clear");
}

void max_jit_gl_syphon_client_free(t_max_jit_gl_syphon_client *x)
{
	max_jit_ob3d_detach(x);
	jit_object_free(max_jit_obex_jitob_get(x));
	max_jit_object_free(x);
}

void max_jit_gl_syphon_client_bang(t_max_jit_gl_syphon_client *x)
{
	// ensure we are properly deferred
	typedmess((t_object *)x,ps_draw,0,NULL);
}

void max_jit_gl_syphon_client_draw(t_max_jit_gl_syphon_client *x, t_symbol *s, long argc, t_atom *argv)
{
	t_atom a;
	// get the jitter object
	t_jit_object *jitob = (t_jit_object*)max_jit_obex_jitob_get(x);
	
	// call the jitter object's draw method
	jit_object_method(jitob,s,s,argc,argv);
	
	// query the texture name and send out the texture output 
	jit_atom_setsym(&a,jit_attr_getsym(jitob,ps_out_name));
	outlet_anything(x->texout,ps_jit_gl_texture,1,&a);
}

void max_jit_gl_syphon_client_getavailableservers(t_max_jit_gl_syphon_client *x)
{    
    t_atom atomName;
    t_atom atomHostName;
    
    // send a clear first.
    outlet_anything(max_jit_obex_dumpout_get(x), ps_clear, 0, 0); 

    for(NSDictionary* serverDict in [[SyphonServerDirectory sharedDirectory] servers])
    {
        NSString* serverName = [serverDict valueForKey:SyphonServerDescriptionNameKey];
        NSString* serverAppName = [serverDict valueForKey:SyphonServerDescriptionAppNameKey];
        
        const char* name = [serverName cStringUsingEncoding:NSUTF8StringEncoding];
        const char* hostName = [serverAppName cStringUsingEncoding:NSUTF8StringEncoding];
                
        atom_setsym(&atomName, gensym((char*)name));
        atom_setsym(&atomHostName, gensym((char*)hostName));

        outlet_anything(x->dumpout, ps_servername, 1, &atomName); 
        outlet_anything(x->dumpout, ps_appname, 1, &atomHostName); 
    }   
}

void *max_jit_gl_syphon_client_new(t_symbol *s, long argc, t_atom *argv)
{
	t_max_jit_gl_syphon_client *x;
	void *jit_ob;
	long attrstart;
	t_symbol *dest_name_sym = _jit_sym_nothing;
	
	if ((x = (t_max_jit_gl_syphon_client *) max_jit_object_alloc(max_jit_gl_syphon_client_class, gensym("jit_gl_syphon_client"))))
	{
		// get first normal arg, the destination name
		attrstart = max_jit_attr_args_offset(argc,argv);
		if (attrstart&&argv) 
		{
			jit_atom_arg_getsym(&dest_name_sym, 0, attrstart, argv);
		}
		
		// instantiate Jitter object with dest_name arg
		if ((jit_ob = jit_object_new(gensym("jit_gl_syphon_client"), dest_name_sym)))
		{
			// set internal jitter object instance
			max_jit_obex_jitob_set(x, jit_ob);
			
			// process attribute arguments 
			max_jit_attr_args(x, argc, argv);		
			

            // add a general purpose outlet (rightmost)
            x->dumpout = outlet_new(x,NULL);
			max_jit_obex_dumpout_set(x, x->dumpout);

			// this outlet is used to shit out textures! yay!
			x->texout = outlet_new(x, "jit_gl_texture");
        } 
		else 
		{
			error("jit.gl.syphon_server: could not allocate object");
			freeobject((t_object *)x);
			x = NULL;
		}
	}
	return (x);
}



