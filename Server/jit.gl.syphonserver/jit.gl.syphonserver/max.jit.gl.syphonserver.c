/*
    max.jit.gl.syphonserver.c
    jit.gl.syphonserver
	
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
#include "jit.gl.h"


typedef struct _max_jit_gl_syphon_server 
{
	t_object		ob;
	void			*obex;
} t_max_jit_gl_syphon_server;

t_jit_err jit_gl_syphon_server_init(void); 

void *max_jit_gl_syphon_server_new(t_symbol *s, long argc, t_atom *argv);
void max_jit_gl_syphon_server_free(t_max_jit_gl_syphon_server *x);

t_class *max_jit_gl_syphon_server_class;

int C74_EXPORT main(void)
{
	t_class *maxclass, *jitclass;

	jit_gl_syphon_server_init();

	maxclass = class_new("jit.gl.syphonserver", (method)max_jit_gl_syphon_server_new, (method)max_jit_gl_syphon_server_free, sizeof(t_max_jit_gl_syphon_server), NULL, A_GIMME, 0);
	max_jit_class_obex_setup(maxclass, calcoffset(t_max_jit_gl_syphon_server, obex));
	jitclass = jit_class_findbyname(gensym("jit_gl_syphon_server"));

	max_jit_class_wrap_standard(maxclass, jitclass, 0);
	max_jit_class_ob3d_wrap(maxclass);
	class_addmethod(maxclass, (method)max_jit_ob3d_assist, "assist", A_CANT, 0);

	max_jit_gl_syphon_server_class = maxclass;
}

void max_jit_gl_syphon_server_free(t_max_jit_gl_syphon_server *x)
{
	max_jit_ob3d_detach(x);
	jit_object_free(max_jit_obex_jitob_get(x));
	max_jit_object_free(x);
}

void *max_jit_gl_syphon_server_new(t_symbol *s, long argc, t_atom *argv)
{
	t_max_jit_gl_syphon_server *x;
	void *jit_ob;
	long attrstart;
	t_symbol *dest_name_sym = _jit_sym_nothing;

	if ((x = (t_max_jit_gl_syphon_server *) max_jit_object_alloc(max_jit_gl_syphon_server_class, gensym("jit_gl_syphon_server"))))
	{
		// get first normal arg, the destination name
		attrstart = max_jit_attr_args_offset(argc,argv);
		if (attrstart&&argv) 
		{
			jit_atom_arg_getsym(&dest_name_sym, 0, attrstart, argv);
		}
		
		// instantiate Jitter object with dest_name arg
		if ((jit_ob = jit_object_new(gensym("jit_gl_syphon_server"), dest_name_sym)))
		{
			// set internal jitter object instance
			max_jit_obex_jitob_set(x, jit_ob);
			
			// add a general purpose outlet (rightmost)
			max_jit_obex_dumpout_set(x, outlet_new(x,NULL));
			
			// process attribute arguments 
			max_jit_attr_args(x, argc, argv);		
			
			// create new proxy inlet.
			max_jit_obex_proxy_new(x, 0);
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


