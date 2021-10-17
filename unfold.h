//
// Created by leo on 2021/5/26.
//

#ifndef PDNET_CHECKER_UNFOLD_H
#define PDNET_CHECKER_UNFOLD_H

#include "cpn.h"
#include "iostream"
#include "vector"
#include <algorithm>
#include <iomanip>//控制cout输出宽度
#include "time.h"

using namespace std;

class Binding_unf {
public:
    string variable;
    token value;
    Binding_unf *next;

    Binding_unf() { value= NULL; }
};

typedef class coset_X {
public:
    int t_idx;
    vector<int> b_idx_vec;

    //coset_X() {  }
} X;

class CUT{
public:
    int e_idx;
    vector<int> b_idx_vec;
};

class Config{
public:
    vector<int> config;    //b_idx_vec
};

typedef struct Possible_Extention {
    int t_idx;
    Binding_unf * bindings;
    X * xs;
    CUT * cut;
} PE;

typedef struct UNF_Small_Arc {
    index_t idx;
} USArc;

typedef class UNF_Place {
public:
    string id;
    int cpn_index;//映射在cpn中对应的库所
    MultiSet token_record;
    MultiSet initMarking;
    vector<USArc> producer;
    vector<USArc> consumer;
} UPlace;

typedef class UNF_Transition {
public:
    string id;
    int cpn_index;
    vector<USArc> producer;
    vector<USArc> consumer;
    CUT *cut;
    vector<Config *> configs;//b_idx
} UTransition;

typedef class UNF_Arc {
public:
    bool isp2t;
    string source_id;
    string target_id;
    condition_tree arc_exp;
    Arc_Type arcType;
    bool deleted;
} UArc;

class UNFPDN {
public:
    UPlace *place;
    UTransition *transition;
    UArc *arc;

    NUM_t placecount;
    NUM_t transitioncount;
    NUM_t arccount;
    //contexts
    vector<vector<int>> matrix_Cob;//concurrency matrix of conditions
    vector<vector<int>> matrix_Conf;//[e]
    vector<set<int>> table_conf_pre;//·[e]
    vector<set<int>> table_conf_con;//[e]·
    vector<set<int>> table_conf_cut;//cut([e])

    vector<PE *> pe;
    vector<Binding_unf *> bindings;//存放当前方法中bindings
    vector<X *> xs;//存放当前方法中xs
    vector<CUT *> cut_off;
    CUT* min_o;
    set<int> posCutoff;

    void print_UNF(string filename,CPN *cpn);
    void get_PosCutoff(CPN *cpn);
    multimap<int, int> map_Plc_cpn2unf;

    void init();

    int findBidx_by_CplaceIdx_and_token(int idx_c, token token,CUT * cut);
    set<int> cutoff_t;
};

class UNFOLD {
public:
    CPN *cpn;
    UNFPDN *unfpdn;

    void getcpn(CPN *cpn);

    void init();

    void fire();

    void unfolding();

    void find_new_pe_by_t(int t_idx,CUT* cut_cur);

    UNFOLD();

    ~UNFOLD();
};


#endif //PDNET_CHECKER_UNFOLD_H
