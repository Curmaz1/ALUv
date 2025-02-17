/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_50(char*, char *);
IKI_DLLESPEC extern void execute_51(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
IKI_DLLESPEC extern void execute_79(char*, char *);
IKI_DLLESPEC extern void execute_69(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void execute_71(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_57(char*, char *);
IKI_DLLESPEC extern void execute_58(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_60(char*, char *);
IKI_DLLESPEC extern void execute_61(char*, char *);
IKI_DLLESPEC extern void execute_62(char*, char *);
IKI_DLLESPEC extern void execute_63(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_65(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void execute_67(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_53(char*, char *);
IKI_DLLESPEC extern void execute_54(char*, char *);
IKI_DLLESPEC extern void execute_55(char*, char *);
IKI_DLLESPEC extern void execute_56(char*, char *);
IKI_DLLESPEC extern void execute_80(char*, char *);
IKI_DLLESPEC extern void execute_81(char*, char *);
IKI_DLLESPEC extern void execute_82(char*, char *);
IKI_DLLESPEC extern void execute_83(char*, char *);
IKI_DLLESPEC extern void execute_84(char*, char *);
IKI_DLLESPEC extern void execute_85(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[34] = {(funcp)execute_50, (funcp)execute_51, (funcp)execute_73, (funcp)execute_74, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_79, (funcp)execute_69, (funcp)execute_70, (funcp)execute_71, (funcp)execute_72, (funcp)execute_57, (funcp)execute_58, (funcp)execute_59, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_64, (funcp)execute_65, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)execute_53, (funcp)execute_54, (funcp)execute_55, (funcp)execute_56, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_83, (funcp)execute_84, (funcp)execute_85, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_2};
const int NumRelocateId= 34;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/ALU_tb_behav/xsim.reloc",  (void **)funcTab, 34);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/ALU_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(8, 10864, 6,0,0,11784, 9,0,0,11416, 8,0,0,10680, 5,0,0,11968, 10,0,0,11232, 7,0,0,10128, 2,0,0,10312, 4,0,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/ALU_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void subprog_m_58c0ed52_f1dbc478_14() ;
void subprog_m_58c0ed52_f1dbc478_17() ;
void subprog_m_58c0ed52_f1dbc478_20() ;
void subprog_m_58c0ed52_f1dbc478_23() ;
void subprog_m_58c0ed52_f1dbc478_26() ;
void subprog_m_58c0ed52_f1dbc478_29() ;
void subprog_m_58c0ed52_f1dbc478_32() ;
void subprog_m_58c0ed52_f1dbc478_35() ;
void subprog_m_58c0ed52_f1dbc478_7() ;
void subprog_m_58c0ed52_f1dbc478_9() ;
void subprog_m_58c0ed52_f1dbc478_11() ;
static char* ng20[] = {(void *)subprog_m_58c0ed52_f1dbc478_14};
static char* ng40[] = {(void *)subprog_m_58c0ed52_f1dbc478_17};
static char* ng50[] = {(void *)subprog_m_58c0ed52_f1dbc478_20};
static char* ng60[] = {(void *)subprog_m_58c0ed52_f1dbc478_23};
static char* ng70[] = {(void *)subprog_m_58c0ed52_f1dbc478_26};
static char* ng80[] = {(void *)subprog_m_58c0ed52_f1dbc478_29};
static char* ng90[] = {(void *)subprog_m_58c0ed52_f1dbc478_32};
static char* ng100[] = {(void *)subprog_m_58c0ed52_f1dbc478_35};
static char* ng110[] = {(void *)subprog_m_58c0ed52_f1dbc478_7};
static char* ng120[] = {(void *)subprog_m_58c0ed52_f1dbc478_9};
static char* ng130[] = {(void *)subprog_m_58c0ed52_f1dbc478_11};
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_xsimdir_location_if_remapped(argc, argv)  ;
    iki_set_sv_type_file_path_name("xsim.dir/ALU_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/ALU_tb_behav/xsim.crvsdump");
    iki_svlog_initialize_virtual_tables(11, 2, ng20, 4, ng40, 5, ng50, 6, ng60, 7, ng70, 8, ng80, 9, ng90, 10, ng100, 11, ng110, 12, ng120, 13, ng130);
    void* design_handle = iki_create_design("xsim.dir/ALU_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
