/*	$OpenBSD: cerror.S,v 1.1 2011/10/17 06:39:20 guenther Exp $	*/
/*	$NetBSD: cerror.S,v 1.3 1996/10/17 03:08:17 cgd Exp $	*/

/*
 * Copyright (c) 1994, 1995 Carnegie-Mellon University.
 * All rights reserved.
 *
 * Author: Chris G. Demetriou
 * 
 * Permission to use, copy, modify and distribute this software and
 * its documentation is hereby granted, provided that both the copyright
 * notice and this permission notice appear in all copies of the
 * software, derivative works or modified versions, and any portions
 * thereof, and that both notices appear in supporting documentation.
 * 
 * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS" 
 * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND 
 * FOR ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
 * 
 * Carnegie Mellon requests users of this software to return to
 *
 *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
 *  School of Computer Science
 *  Carnegie Mellon University
 *  Pittsburgh PA 15213-3890
 *
 * any improvements or extensions that they make and grant Carnegie the
 * rights to redistribute these changes.
 */

#include "SYS.h"

#define	FRAME_SIZE		16
#define	FRAME_RA_OFFSET		0
#define	FRAME_V0_OFFSET		8

NESTED(__cerror, 0, FRAME_SIZE, ra, IM_RA|IM_V0, 0)
LEAF_NOPROFILE(__cerror, 0)
	br	t0, L1
L1:	LDGP(t0)

	lda	sp, -FRAME_SIZE(sp)
	stq	ra, FRAME_RA_OFFSET(sp)
	stq	v0, FRAME_V0_OFFSET(sp)

	CALL(__errno)

	ldq	t0, FRAME_V0_OFFSET(sp)
	stl	t0, 0(v0)
	ldiq	v0, -1
	ldq	ra, FRAME_RA_OFFSET(sp)
	lda	sp, FRAME_SIZE(sp)
	RET
END(__cerror)
