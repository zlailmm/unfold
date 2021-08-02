//
// Created by leo on 2021/5/26.
//

#include "unfold.h"

/*
 * 0-CPN的初始标识，库所p中有颜色为c的token，将含初始标识的库所转化为条件b，并用(p,c)标记；
   1-选择一个变迁t；
   2-对于变迁t的每个前集库所，寻找被(p,c)标记的副本b，并放入颜色为c的token。若找不到返回第1步；
   3-对于变迁t的所有绑定bp，是一个绑定元素（t，bp），
   3.1- 对于 (t, bp) ，新建事件e ，并标记为t。
   3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
   4- 返回第1步。
 */
typedef unordered_map<token, token_count_t, tokenHasher, tokenEqualto> Token_map;
extern string tid_str;

void UNFOLD::getcpn(CPN *input_cpn) {
    cpn = input_cpn;
}

void UNFPDN::init() {
    placecount = transitioncount = 0;
    place = new UPlace[400];
    transition = new UTransition[400];
    cut_off.clear();
    min_o = new CUT;
}


vector<vector<pair<int, token>>> get_token_vector(CTransition *t, CPN *cpn) {
    vector<vector<pair<int, token>>> binding_1;//int:cpn库所idx
    vector<pair<int, token>> binding_2;
    CPlace *place;
    token tmp_token;
    Token_map tmp_token_map;
//    for (auto i = t.producer.cbegin(); i != t.producer.cend(); i++) {
    for (int j = 0; j < t->get_producer().size(); j++) {
        auto i = t->get_producer()[j];
        place = cpn->findP_byindex(i.idx);
        tmp_token_map = place->getMultiSet().getmapTokens();
//        if (tmp_token_map->next != NULL) {
        if (!tmp_token_map.empty()) {
//            num_token_idx = 1;
            cout << place->getid() << "  :";
            binding_2.clear();
//            while (tmp_token_map->next != NULL) {
//                tmp_token_map = tmp_token_map->next;
//                binding_2.push_back(make_pair(place.id, tmp_token_map));
//                num_token_idx++;
//            }
            for (auto k = tmp_token_map.begin(); k != tmp_token_map.end(); k++) {
                binding_2.push_back(make_pair(i.idx, k->first));
            }
            binding_1.push_back(binding_2);
        }
        cout << endl;
    }
    //查看binding_1中的内容
//    for(auto i=binding_1.cbegin();i!=binding_1.cend();i++){
//        for(auto j=i->cbegin();j!=i->cend();j++) {
//            cout << "(" << j->first << "," << j->second->tokencount << ")";
//        }
//            cout<<endl;
//    }
    return binding_1;

}

vector<int> indexes;

void build_binding_vector(vector<vector<pair<int, token>>> &token_vec,
                          vector<vector<pair<int, token>>> &binding_vec, uint32_t level = 0) {
    std::vector<pair<int, token>> vci;
    if (level < token_vec.size()) {
        for (size_t i = 0; i < token_vec[level].size(); i++) {
            indexes[level] = i;
            build_binding_vector(token_vec, binding_vec, level + 1);
        }
    } else {
        for (size_t i = 0; i < token_vec.size(); i++) {
            vci.push_back(token_vec[i][indexes[i]]);
        }
        binding_vec.push_back(vci);
    }
}

//判断b是否为a的祖先
bool is_causal_s(UPlace a, UPlace b, UNFPDN *unfpdn) {
    if (a.id == b.id) {
        return true;
    }

    if (!a.producer.empty()) {
        auto pro_t = unfpdn->transition[a.producer.begin()->idx];
        auto pro_pro_SArc = pro_t.producer;
        for (auto i = pro_pro_SArc.begin(); i != pro_pro_SArc.end(); i++) {
            auto pro_pro_p = unfpdn->place[i->idx];
            if (is_causal_s(pro_pro_p, b, unfpdn))
                return true;
        }
    }

    return false;
}

bool is_causal(UPlace a, UPlace b, UNFPDN *unfpdn) {
    if (is_causal_s(a, b, unfpdn))
        return true;
    if (is_causal_s(b, a, unfpdn))
        return true;
    else return false;
}

//查找a的祖先库所
void find_place_ancestor(UPlace a, UNFPDN *unfpdn, vector<int> &ancestor_vec) {
    while (!a.producer.empty()) {
        auto pro_t = unfpdn->transition[a.producer.begin()->idx];
        auto pro_pro_SArc = pro_t.producer;
        for (auto i = pro_pro_SArc.begin(); i != pro_pro_SArc.end(); i++) {
            ancestor_vec.push_back(i->idx);
            find_place_ancestor(unfpdn->place[i->idx], unfpdn, ancestor_vec);
        }
    }
}

bool is_conflict(UPlace a, UPlace b, UNFPDN *unfpdn) {
    vector<int> ancestor_a, ancestor_b;
    find_place_ancestor(a, unfpdn, ancestor_a);
    find_place_ancestor(b, unfpdn, ancestor_b);
    for (auto i = ancestor_a.begin(); i != ancestor_a.end(); i++) {
        for (auto j = ancestor_b.begin(); j != ancestor_b.end(); j++) {
            if (*i == *j)
                return true;
        }
    }
    return false;
}

//void get_coset(UNFPDN *unfpdn) {
//    auto tmpbinding = unfpdn->bindings.begin();
//
//    for (auto i = unfpdn->xs.begin(); i != unfpdn->xs.end(); i++) {
//        bool found = 0;
//        auto x_mem1 = *i;
//        while (x_mem1->next && x_mem1->next->next && found == 0) {
//            x_mem1 = x_mem1->next;
//            auto b1 = unfpdn->place[unfpdn->findBidx_by_CplaceIdx_and_token(x_mem1->place_idx,
//                                                                            x_mem1->ms.getonlytoken())];
//            auto x_mem2 = x_mem1->next;
//            while (x_mem2 && found == 0) {
//                auto b2 = unfpdn->place[unfpdn->findBidx_by_CplaceIdx_and_token(x_mem2->place_idx,
//                                                                                x_mem2->ms.getonlytoken())];
//                if (is_causal(b1, b2, unfpdn) || is_conflict(b1, b2, unfpdn))
//                    found = 1;
//                x_mem2 = x_mem2->next;
//            }
//        }
//        if (found) {
//            i = unfpdn->xs.erase(i);
//            tmpbinding = unfpdn->bindings.erase(tmpbinding);
//        } else
//            tmpbinding++;
//    }
//
//
//    for (auto i = binding_token.begin(); i != binding_token.end(); i++) {
//        producer_vector.clear();
//        for (auto j = i->begin(); j != i->end(); j++) {
//            for (auto k = unfpdn->map_Plc_cpn2unf.lower_bound(j->first);
//                 k != unfpdn->map_Plc_cpn2unf.upper_bound(j->first); k++) {
//                if (unfpdn->place[k->second].initMarking.getonlytoken() == j->second) {
//                    producer_vector.push_back(unfpdn->place[k->second]);
//                }
//            }
//        }
//
//        for (auto j = producer_vector.begin(); j != producer_vector.end(); j++) {
//            for (auto k = j + 1; k != producer_vector.end(); k++) {
//                if (is_causal(*j, *k, unfpdn) || is_conflict(*j, *k, unfpdn)) {
//                    i = binding_token.erase(i);
//                }
//            }
//        }
//    }
//}

int UNFPDN::findBidx_by_CplaceIdx_and_token(int idx_c, token token, CUT *cut) {
    for (auto i = cut->b_idx_vec.begin(); i != cut->b_idx_vec.end(); i++) {
        auto b_idx = *i;
        if (place[b_idx].cpn_index == idx_c && place[b_idx].token_record.getonlytoken() == token)
            return b_idx;
    }
    cerr << "can't findBidx_by_CplaceIdx_and_token" << endl;
}
bool e_has_one_propro(int e_idx, UNFPDN *unfpdn){
    auto e_pro=unfpdn->transition[e_idx].producer;
    set<int> e_idx_propro_set;
    for(auto i=e_pro.begin();i!=e_pro.end();i++){
        auto b_pro=unfpdn->place[i->idx];
        if(b_pro.producer.size()==0)
            return false;
        auto e_idx_propro=b_pro.producer[0].idx;
        e_idx_propro_set.insert(e_idx_propro);
    }
    if (e_idx_propro_set.size()==1)
        return true;
    else return false;
}

CUT *get_cut_onepropro(int e_idx, UNFPDN *unfpdn) {
    CUT *cut_e = new CUT;
    vector<int> tmp_cut;
    tmp_cut.clear();

    auto e=unfpdn->transition[e_idx];
    auto e_pro=unfpdn->transition[e_idx].producer;
    auto e_propro_idx=unfpdn->place[e_pro.begin()->idx].producer.begin()->idx;
    auto e_propro=unfpdn->transition[e_propro_idx];
    tmp_cut = e_propro.cut->b_idx_vec;

    for (auto i = 0; i < e.consumer.size(); i++) {
        tmp_cut.push_back(e.consumer[i].idx);
    }

    for (auto i = 0; i < e.producer.size(); i++) {
        auto pos = find(tmp_cut.begin(), tmp_cut.end(), e.producer[i].idx);
        tmp_cut.erase(pos);
    }
    cut_e->b_idx_vec = tmp_cut;
    cut_e->e=e_idx;
    return cut_e;
}

vector<int> get_config_e(int e_idx, UNFPDN *unfpdn) {
    vector<int> result;
    result.push_back(e_idx);
    if (!unfpdn->transition[e_idx].producer.empty()) {
        auto t = unfpdn->transition[e_idx];
        auto pro_SArc = t.producer;
        for (auto i = pro_SArc.begin(); i != pro_SArc.end(); i++) {
            if (unfpdn->place[i->idx].producer.empty())
                continue;
            int pro_pro_t_idx = unfpdn->place[i->idx].producer.front().idx;
            auto tmp_vec = get_config_e(pro_pro_t_idx, unfpdn);
            result.insert(result.end(), tmp_vec.begin(), tmp_vec.end());
        }
    }
    set<int> s(result.begin(), result.end());//去重
    result.assign(s.begin(), s.end());
    return result;
}

CUT *get_cut(int e_idx, UNFPDN *unfpdn) {
    vector<int> config_e = get_config_e(e_idx, unfpdn);
    CUT *cut_e = new CUT;
    vector<int> tmp_cut;
    tmp_cut.clear();
    tmp_cut = unfpdn->min_o->b_idx_vec;

    for (auto i = config_e.begin(); i != config_e.end(); i++) {
        auto e_idx = *i;
        auto e = unfpdn->transition[e_idx];
        for (auto j = 0; j < e.consumer.size(); j++) {
            tmp_cut.push_back(e.consumer[j].idx);
        }
    }
    for (auto i = config_e.begin(); i != config_e.end(); i++) {
        auto e_idx = *i;
        auto e = unfpdn->transition[e_idx];
        for (auto j = 0; j < e.producer.size(); j++) {
            auto pos = find(tmp_cut.begin(), tmp_cut.end(), e.producer[j].idx);
            tmp_cut.erase(pos);
        }
    }
    cut_e->b_idx_vec = tmp_cut;
    cut_e->e=e_idx;
    return cut_e;
}

bool cmp(const pair<int, token> a, const pair<int, token> b) {
    return a.first < b.first;//自定义的比较函数
}

bool is_cut_off(CUT *cut_e, UNFPDN *unfpdn,int &t_idx_same_cut) {
    if (unfpdn->cut_off.empty())
        return false;
    for (auto i = unfpdn->cut_off.begin(); i != unfpdn->cut_off.end(); i++) {
        auto cut_off_point = *i;
        vector<pair<int, token>> h_cut_off;
        vector<pair<int, token>> h_cut_e;
        for (auto j = 0; j < cut_off_point->b_idx_vec.size(); j++) {
            auto vec = cut_off_point->b_idx_vec;
            if(unfpdn->place[vec[j]].token_record.getcolorcount()==0)
                cout<<vec[j];
            h_cut_off.push_back(make_pair(unfpdn->place[vec[j]].cpn_index, unfpdn->place[vec[j]].token_record.getonlytoken()));
        }
        for (auto j = 0; j < cut_e->b_idx_vec.size(); j++) {
            auto vec = cut_e->b_idx_vec;
            h_cut_e.push_back(make_pair(unfpdn->place[vec[j]].cpn_index, unfpdn->place[vec[j]].token_record.getonlytoken()));
        }
        sort(h_cut_off.begin(), h_cut_off.end(), cmp);
        sort(h_cut_e.begin(), h_cut_e.end(), cmp);
        t_idx_same_cut = cut_off_point->e;
        if (h_cut_e == h_cut_off) {
            return true;
        }
    }
    return false;
}

vector<String_t> merge_vec_unf(vector<String_t> vec1, vector<String_t> vec2) {
    if (vec1.empty())
        return vec2;
    if (vec2.empty()) {
        vec1.clear();
        return vec1;
    }
//    bool finded_flag = false;
    for (auto iter = vec1.begin(); iter != vec1.end();) {
        if (exist_in(vec2, *iter))
            iter++;
        else
            iter = vec1.erase(iter);
    }
    return vec1;
}

vector<X *> merge_vec_unf(vector<X *> vec1, vector<X *> vec2) {
    if (vec1.empty())
        return vec2;
    if (vec2.empty()) {
        vec1.clear();
        return vec1;
    }
//    bool finded_flag = false;
    for (auto iter = vec1.begin(); iter != vec1.end();) {
        if (exist_in(vec2, *iter))
            iter++;
        else
            iter = vec1.erase(iter);
    }
    return vec1;
}

Binding_unf *bindingcid_unf(Product_t cid, SORTID sid, condition_tree_node *tokennode) {
    condition_tree_node *node = tokennode->left;
    int offset = 0;
    Binding_unf *newbinding, *result;
    result = new Binding_unf;
    result->next = NULL;
    auto ps = sorttable.find_productsort(sid);
    auto sortid = ps.get_sortid();
    while (node->right) {
        if (node->left->node_type == variable) {
            if (node->node_name != tid_str) {
                newbinding = new Binding_unf;
                newbinding->variable = node->left->value;
                if (sortid[offset].tid == Integer)
                    newbinding->value = fint.generateSortValue();
                else if (sortid[offset].tid == Real)
                    newbinding->value = freal.generateSortValue();
                else if (sortid[offset].tid == String)
                    newbinding->value = fstr.generateSortValue();
                else {
                    cerr << "ERROR!variable can not be a productsort!" << endl;
                    exit(-1);
                }
                Bucket bkt;
                cid[offset]->getcolor(bkt);
                newbinding->value->setcolor(bkt);
//                color_copy(sortid[offset].tid, sortid[offset].sid, cid[offset], newbinding->value);
                newbinding->next = result->next;
                result->next = newbinding;
            }
        }
        offset++;
        node = node->right;
    }
    if (node->node_type == variable) {
        if (node->node_name != tid_str) {
            newbinding = new Binding_unf;
            newbinding->variable = node->value;
            if (sortid[offset].tid == Integer)
                newbinding->value = fint.generateSortValue();
            else if (sortid[offset].tid == Real)
                newbinding->value = freal.generateSortValue();
            else if (sortid[offset].tid == String)
                newbinding->value = fstr.generateSortValue();
            else {
                cerr << "ERROR!variable can not be a productsort!" << endl;
                exit(-1);
            }
            Bucket bkt;
            cid[offset]->getcolor(bkt);
            newbinding->value->setcolor(bkt);
//            color_copy(sortid[offset].tid, sortid[offset].sid, cid[offset], newbinding->value);
            newbinding->next = result->next;
            result->next = newbinding;
        }
    }
    return result;
}

Binding_unf *bindingToken(condition_tree_node *node, int place_idx, TID_t tid, UNFPDN *unfpdn, CPN *cpn,CUT *cut) {


    SORTID sid;
    bool hasindex, hastid;
    Binding_unf *result, *tmpbinding;
//    MultiSet multiset = cpn->findP_byindex(place_idx)->getMultiSet();
    MultiSet multiset;
    for(auto i=cut->b_idx_vec.begin();i!=cut->b_idx_vec.end();i++){
        if(unfpdn->place[*i].cpn_index==place_idx)
            multiset=unfpdn->place[*i].token_record;
    }
//    Tokens *tokens = multiset->tokenQ->next;

    result = new Binding_unf;
    result->next = NULL;

    bool found=0;
    for(auto i=cut->b_idx_vec.begin();i!=cut->b_idx_vec.end();i++){
        auto b=unfpdn->place[*i];
        if(b.cpn_index==place_idx)
            found=1;
    }
    if(!found)
        return result;

    //binding Integer, for alloc and mutex cond
    if (multiset.gettid() == Integer) {
        if (node->left->node_name[0] == '_' || isalpha(node->left->node_name[0])) {
            result->next = new Binding_unf;
            result->next->next = NULL;
            result->next->variable = node->left->node_name;
            result->next->value = fint.generateSortValue();
            Bucket bkt;
            token token;
            for(auto i=cut->b_idx_vec.begin();i!=cut->b_idx_vec.end();i++){
                if(unfpdn->place[*i].cpn_index==place_idx)
                    token=unfpdn->place[*i].token_record.getonlytoken();
            }
//            auto condition = unfpdn->place[unfpdn->map_Plc_cpn2unf.lower_bound(place_idx)->second];
//            auto token = condition.initMarking.getonlytoken();
            token->getcolor(bkt);
            result->next->value->setcolor(bkt);
//            color_copy(Integer, 0, tokens->color, result->next->value);

            return result;
        } else
            return result;
    }


    sid = multiset.getsid();
    auto ps = sorttable.find_productsort(sid);
    hasindex = ps.get_hasindex();
    hastid = ps.get_hastid();

    int offset = 0;
    token cid;
    cid = fpro.generateSortValue(sid);
    Integer_t index;
    condition_tree_node *indexnode, *tidnode;
    indexnode = tidnode = node->left;

    if (hasindex && hastid) {
        tidnode = tidnode->right->right;
        while (tidnode->right) {
            indexnode = indexnode->right;
            tidnode = tidnode->right;
            offset++;
        }
        index = atoi(indexnode->left->value.c_str());
        bool notfound = 1;
//        auto c2b = unfpdn->map_Plc_cpn2unf.lower_bound(place_idx);
        for (auto i=cut->b_idx_vec.begin(); i != cut->b_idx_vec.end(); i++) {
            if(unfpdn->place[*i].cpn_index!=place_idx)
                continue;
            Bucket cid_bkt, tid_bkt, index_bkt;
//            auto token = unfpdn->place[c2b->second].initMarking.getonlytoken();
            auto token =unfpdn->place[*i].token_record.getonlytoken();
            token->getcolor(cid_bkt);
            cid->setcolor(cid_bkt);
            TID_t sub_tid;
            Integer_t sub_index;
            cid_bkt.pro[offset - 1 + 1]->getcolor(index_bkt);
            cid_bkt.pro[offset - 1 + 3]->getcolor(tid_bkt);
            sub_index = index_bkt.integer;
            sub_tid = tid_bkt.str;
            if (sub_index == index && tid == sub_tid) {
                notfound = 0;
                tmpbinding = bindingcid_unf(cid_bkt.pro, sid, node);
                Binding_unf *end = tmpbinding;
                while (end->next)
                    end = end->next;
                end->next = result->next;
                result->next = tmpbinding->next;
                delete tmpbinding;
                break;
            }
        }
        if (notfound)
            throw "ERROR!can't binding correctly!";
    } else if (hasindex) {
        tidnode = tidnode->right->right;
        while (tidnode) {
            indexnode = indexnode->right;
            tidnode = tidnode->right;
            offset++;
        }
        index = atoi(indexnode->left->value.c_str());
        bool notfound = 1;
//        auto c2b = unfpdn->map_Plc_cpn2unf.lower_bound(place_idx);
//        for (; c2b != unfpdn->map_Plc_cpn2unf.upper_bound(place_idx); c2b++) {
        for (auto i=cut->b_idx_vec.begin(); i != cut->b_idx_vec.end(); i++) {
            if(unfpdn->place[*i].cpn_index!=place_idx)
                continue;
            Bucket cid_bkt, index_bkt;
            auto token = unfpdn->place[*i].token_record.getonlytoken();
            token->getcolor(cid_bkt);
            Integer_t sub_index;
            cid_bkt.pro[offset - 1 + 1]->getcolor(index_bkt);
            sub_index = index_bkt.integer;
            if (sub_index == index) {
                notfound = 0;
                tmpbinding = bindingcid_unf(cid_bkt.pro, sid, node);
                Binding_unf *end = tmpbinding;
                while (end->next)
                    end = end->next;
                end->next = result->next;
                result->next = tmpbinding->next;
                delete tmpbinding;
                break;
            }
        }
        if (notfound)
            throw "ERROR!can't binding correctly!";
    } else if (hastid) {
        tidnode = tidnode->right;
        while (tidnode->right) {
            tidnode = tidnode->right;
            offset++;
        }
        bool notfound = 1;
//        auto c2b = unfpdn->map_Plc_cpn2unf.lower_bound(place_idx);
//        for (; c2b != unfpdn->map_Plc_cpn2unf.upper_bound(place_idx); c2b++) {
        for (auto i=cut->b_idx_vec.begin(); i != cut->b_idx_vec.end(); i++) {
            if(unfpdn->place[*i].cpn_index!=place_idx)
                continue;
            Bucket cid_bkt, tid_bkt;
            auto token = unfpdn->place[*i].token_record.getonlytoken();
            token->getcolor(cid_bkt);
            TID_t sub_tid;
            cid_bkt.pro[offset - 1 + 2]->getcolor(tid_bkt);
            sub_tid = tid_bkt.str;
            if (sub_tid == tid) {
                notfound = 0;
                tmpbinding = bindingcid_unf(cid_bkt.pro, sid, node);
                Binding_unf *end = tmpbinding;
                while (end->next)
                    end = end->next;
                end->next = result->next;
                result->next = tmpbinding->next;
                delete tmpbinding;
                break;
            }
        }
        if (notfound)
            throw "ERROR!can't binding correctly!";
    } else {
        tidnode = tidnode->right;
        while (tidnode) {
            tidnode = tidnode->right;
            offset++;
        }
        bool notfound = 1;
//        auto c2b = unfpdn->map_Plc_cpn2unf.lower_bound(place_idx);
//        for (; c2b != unfpdn->map_Plc_cpn2unf.upper_bound(place_idx); c2b++) {
        for (auto i=cut->b_idx_vec.begin(); i != cut->b_idx_vec.end(); i++) {
            if(unfpdn->place[*i].cpn_index!=place_idx)
                continue;
            Bucket cid_bkt;
            auto token = unfpdn->place[*i].token_record.getonlytoken();
            token->getcolor(cid_bkt);
            {
                notfound = 0;
                tmpbinding = bindingcid_unf(cid_bkt.pro, sid, node);
                Binding_unf *end = tmpbinding;
                while (end->next)
                    end = end->next;
                end->next = result->next;
                result->next = tmpbinding->next;
                delete tmpbinding;
                break;
            }
        }
        if (notfound)
            throw "ERROR!can't binding correctly!";
    }
//    delete[] cid;
    return result;
}

void UNFOLD::get_bindings_and_x(int t_idx, CUT *cut) {
    unfpdn->bindings.clear();
    unfpdn->xs.clear();

    vector<Binding_unf *> bindings;
    vector<X *> xs;

    Binding_unf *binding, *tmpbinding;
    X *x, *tmpx;

    vector<TID_t> possible, tmp_vec;
    vector<X *> possible_x, tmp_vec_x;

    CTransition *t = cpn->findT_byindex(t_idx);
    auto T_producer = t->get_producer();

    for (int i = 0; i < T_producer.size(); i++) {
        index_t idx = T_producer[i].idx;
        condition_tree_node *root = T_producer[i].arc_exp.getroot();//transition->producer[i].arc_exp.root;
        auto pp = cpn->findP_byindex(idx);
        if (pp->getiscontrolP()) {
            if (pp->gettid() == TID_colorset) {
                if (root->node_type == Token) {
                    if (root->left->node_type == variable) {
                        // arc_exp is 1'tid
                        string var = root->left->value;
//                        auto vv = cpn->findVar_byname(var);
//                        auto iter = cpn->mapVariable.find(var);
//                        if(iter != cpn->mapVariable.end()){
                        TID_t cid;
//                            Tokens *token = marking.mss[idx].tokenQ->next;

                        tmp_vec.clear();
                        for (auto j = cut->b_idx_vec.begin(); j != cut->b_idx_vec.end(); j++) {
                            auto b_idx = *j;
                            if (unfpdn->place[b_idx].cpn_index != idx)
                                continue;
                            auto token = unfpdn->place[b_idx].token_record.getonlytoken();
                            Bucket bkt;
                            token->getcolor(bkt);
                            if (TID_colorset != String)
                                throw "here we assume TID_colorset is String!";
                            tmp_vec.push_back(bkt.str);

                            //X
                            auto tmp_x = new X;
                            tmp_x->b_idx = b_idx;
                            tmp_vec_x.push_back(tmp_x);
                            //X
                        }
                        possible = merge_vec_unf(possible, tmp_vec);
                        possible_x = merge_vec_unf(possible_x, tmp_vec_x);
                        if (possible.empty()) {
                            unfpdn->bindings = bindings;
                            unfpdn->xs = xs;
                            return;//empty return
                        }
//                        else {
//                            cout << "cpn_rg.cpp can't find variable" << endl;
//                            exit(-1);
//                        }
                    } else {
                        // arc_exp is color or case
//                        TID_t cid1,cid2;
//                        Tokens *token = marking.mss[idx].tokenQ->next;
                        MultiSet tmp_ms;
                        bool finded = false;
//                        tmp_ms.tid = TID_colorset;
//                        tmp_ms.sid = 0;

                        cpn->CT2MS(T_producer[i].arc_exp, tmp_ms, TID_colorset, 0);
                        for (auto j = cut->b_idx_vec.begin(); j != cut->b_idx_vec.end(); j++) {
                            auto b_idx = *j;
                            if (unfpdn->place[b_idx].cpn_index != idx)
                                continue;
                            auto token = unfpdn->place[b_idx].token_record.getonlytoken();
                            Bucket bkt1, bkt2;
                            token->getcolor(bkt1);
//                            tmp_ms.Exp2MS(cpn,root,0,0,false);
//                            tmp_ms.tokenQ->next->color->getColor(cid2);
                            tmp_ms.getonlytoken()->getcolor(bkt2);
                            if (bkt1 == bkt2) {
                                finded = true;
                                break;
                            }
                        }
                        if (finded)
                            continue;
                        else {
                            unfpdn->bindings = bindings;
                            unfpdn->xs = xs;
                            return;
                        }
                    }
                } else
                    throw "ERROR!control places' read arc just have one token!";
            } else if (pp->gettid() == Integer) {
                //mutex cond
//                Tokens *token = marking.mss[idx].tokenQ->next;
                Integer_t cid_arc = atoi(root->left->node_name.c_str());
                Bucket bkt_arc;
                bkt_arc.tid = Integer;
                bkt_arc.integer = cid_arc;
                bool found = 0;
                for (auto j = cut->b_idx_vec.begin(); j != cut->b_idx_vec.end(); j++) {
                    auto b_idx = *j;
                    if (unfpdn->place[b_idx].cpn_index != idx)
                        continue;
                    Bucket bkt_place;
                    auto token = unfpdn->place[b_idx].token_record.getonlytoken();
                    token->getcolor(bkt_place);
                    if (bkt_arc == bkt_place) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    unfpdn->bindings = bindings;
                    unfpdn->xs = xs;
                    return;//empty return
                }
            }
        }
    }

    for (int i = 0; i < possible.size(); i++) {
        Bucket bkt_tid;
        String_t tid = possible[i];
        bkt_tid.tid = String;
        bkt_tid.str = tid;
        binding = new Binding_unf;
        binding->next = new Binding_unf;
        binding->next->variable = tid_str;
        binding->next->value = fstr.generateSortValue();
        binding->next->value->setcolor(bkt_tid);
        binding->next->next = NULL;

        x = new X;
        x->next = new X;
        x->next->b_idx = possible_x[i]->b_idx;
        x->next->next = NULL;

        auto T_producer = cpn->findT_byindex(t_idx)->get_producer();
        bool has_token=1;
        for (unsigned int j = 0; j < T_producer.size(); j++) {
            index_t idx = T_producer[j].idx;
            auto pp = cpn->findP_byindex(idx);
            if (!pp->getiscontrolP()) {
                condition_tree_node *root = T_producer[j].arc_exp.getroot();
                while (root) {
                    if (root->node_type == CaseOperator && !root->right) {
                        root = root->left;
                        continue;
                    }
                    if (root->node_type == Token) {

                        tmpbinding = bindingToken(root, idx, tid, unfpdn, cpn, cut);
                        if (tmpbinding->next) {
                            Binding_unf *end = tmpbinding->next;
                            while (end->next)
                                end = end->next;
                            end->next = binding->next;
                            binding->next = tmpbinding->next;
                            delete tmpbinding;
                        }
                        else
                            has_token=0;
                    }
                    if (root->left->node_type == Token) {
                        tmpbinding = bindingToken(root->left, idx, tid, unfpdn, cpn,cut);
                        if (tmpbinding->next) {
                            Binding_unf *end = tmpbinding->next;
                            while (end->next)
                                end = end->next;
                            end->next = binding->next;
                            binding->next = tmpbinding->next;

                            delete tmpbinding;
                        }
                        else
                            has_token=0;
                    }
                    root = root->right;
                }
            }
        }
        if(!has_token)
            continue;
        bindings.push_back(binding);
        xs.push_back(x);
    }
    unfpdn->bindings = bindings;
    unfpdn->xs = xs;
}

void BindingVariable(const Binding_unf *binding, CPN *cpn) {
    Binding_unf *tmp = binding->next;
    while (tmp) {
        auto vv = cpn->findVar_byname(tmp->variable);
//        auto viter = cpn->mapVariable.find(tmp->variable);
//        if(viter == cpn->mapVariable.end()){
//            cerr<<"ERROR!BindingVariable failed!"<<endl;
//            exit(-1);
//        }
//        color_copy(cpn->vartable[viter->second].tid,cpn->vartable[viter->second].sid,tmp->value,cpn->vartable[viter->second].value);
        Bucket bkt;
        tmp->value->getcolor(bkt);
        vv->setvcolor(bkt);
        tmp = tmp->next;
    }
}

bool is_in_pe(PE *pe, vector<PE *> pe_unf) {
    for (auto i = 0; i < pe_unf.size(); i++) {
        bool not_this = 0;
        if (pe->t_idx != pe_unf[i]->t_idx)
            continue;
        auto pebinding = pe->bindings->next;
        auto unfbinding = pe_unf[i]->bindings->next;
        while (pebinding) {
            Bucket bkt1,bkt2;
            unfbinding->value->getcolor(bkt1);
            pebinding->value->getcolor(bkt2);
            if (unfbinding->variable == pebinding->variable && !(bkt1==bkt2))
                not_this = 1;
            unfbinding = unfbinding->next;
            pebinding = pebinding->next;
        }
        if (not_this) {
            continue;
        } else
            return true;
    }
    return false;
}

void UNFOLD::find_new_pe_by_t(int t_idx, CUT *cut,int t_cut_idx) {
    CTransition *t_cpn = cpn->findT_byindex(t_idx);
    vector<vector<pair<int, token>>> token_vector, binding_vector;

//    for (auto i = t_cpn->get_producer().begin(); i != t_cpn->get_producer().end(); i++) {
//        //判断cpn->place[j->idx]是否有对应的b   j->idx指cpn中place的下标
//        if (unfpdn->map_Plc_cpn2unf.find(i->idx) == unfpdn->map_Plc_cpn2unf.cend()) {
//            return;
//        }
//        bool has_token = 0;
//        auto j = unfpdn->map_Plc_cpn2unf.lower_bound(i->idx);
//        for (; j != unfpdn->map_Plc_cpn2unf.upper_bound(i->idx); j++) {
//            if (unfpdn->place[j->second].initMarking.getcolorcount() != 0) {
//                has_token = 1;
//            }
//        }
//        if (!has_token)
//            return;
//    }
    //    3-对于变迁t的所有绑定bp，是一个绑定元素（t，bp），
    //    3.1- 对于 (t, bp) ，新建事件e ，并标记为t。
    //    3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
    //    4- 返回第1步。
    //cout << i << ":" << cpn->transition[i].producer.size() << " ";
    //cout<<i<<"endl";

    //token_vector = get_token_vector(t_cpn, cpn);//token_vector保存t的前置库所的token  行：库所  列：token
//    indexes.resize(token_vector.size());
//    indexes.clear();
    //build_binding_vector(token_vector, binding_vector);

    //get_binding
    get_bindings_and_x(t_idx, cut);
    if (unfpdn->bindings.empty())
        return;
    //judge guard
    if (t_cpn->get_hasguard()) {
        auto iter_x = unfpdn->xs.begin();
        for (auto iter = unfpdn->bindings.begin(); iter != unfpdn->bindings.end();) {
            Integer_t res;
            MultiSet ms;

//            ms.tid = Integer;
//            ms.sid = 0;
            BindingVariable(*iter, cpn);
//            ms.Exp2MS(cpn,transition->guard.root,0,0,false);
//            ms.tokenQ->next->color->getColor(res);
            cpn->CT2MS(t_cpn->get_guard(), ms, Integer, 0);
            Bucket bkt;
            ms.getonlytoken()->getcolor(bkt);
            res = bkt.integer;
            if (res == 0) {
                iter = unfpdn->bindings.erase(iter);
                iter_x = unfpdn->xs.erase(iter_x);
            } else {
                iter++;
                iter_x++;
            }
        }
    }

    //judge co-set
    //get_coset(unfpdn);

    //新建事件e


    //    3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
    //    4- 返回第1步。

    //产生pe
    for (auto i = 0; i < unfpdn->bindings.size(); i++) {
        PE *tmp_pe = new PE;
        tmp_pe->t_idx = t_idx;
        tmp_pe->bindings = unfpdn->bindings[i];
        tmp_pe->xs = unfpdn->xs[i];
        tmp_pe->cut = cut;
        tmp_pe->t_cut_idx=t_cut_idx;
        if (is_in_pe(tmp_pe, unfpdn->pe))
            continue;
        int t_idx_same_cut;
//        if(is_cut_off(cut,unfpdn,t_idx_same_cut))
//            continue;
        cout << "find new pe t_idx=" << t_idx << endl;
        unfpdn->pe.push_back(tmp_pe);
    }
}

void merge_cut(int e_cut_idx,int e_idx,UNFPDN *unfpdn){
    auto b_idx_vec=unfpdn->transition[e_idx].cut->b_idx_vec;
    auto b_idx_cut_vec=unfpdn->transition[e_cut_idx].cut->b_idx_vec;
    for(auto i=b_idx_vec.begin();i!=b_idx_vec.end();i++){
        b_idx_cut_vec.push_back(*i);
    }
    set<int> s(b_idx_cut_vec.begin(), b_idx_cut_vec.end());//去重
    unfpdn->transition[e_cut_idx].cut->b_idx_vec.assign(s.begin(), s.end());
}
void UNFOLD::init() {
    setvbuf(stdout, NULL, _IONBF, 0);
    unfpdn = new UNFPDN;
    unfpdn->init();
    Token_map tmp_token_map;
    MultiSet tmp_multiset;


//    00-CPN的初始标识，库所p中有颜色为c的token，将含初始标识的库所转化为条件b，并用(p,c)标记；
    for (int i = 0; i < cpn->get_placecount(); i++) {
        tmp_multiset = cpn->findP_byindex(i)->getMultiSet();
        tmp_token_map = tmp_multiset.getmapTokens();
        auto tmp_token = tmp_token_map.begin();
        while (tmp_token != tmp_token_map.end()) {
//            Bucket tmp_bucket;
            unfpdn->place[unfpdn->placecount].id = "B" + to_string(unfpdn->placecount);
            unfpdn->place[unfpdn->placecount].cpn_index = i;
//            tmp_token->first->getcolor(tmp_bucket);
            unfpdn->place[unfpdn->placecount].token_record.generateFromToken(tmp_token->first);
            unfpdn->place[unfpdn->placecount].initMarking.generateFromToken(tmp_token->first);//保存token的值
//            unfpdn->place[unfpdn->placecount].token_count = 0;//初始b清空标记
            unfpdn->map_Plc_cpn2unf.insert(
                    make_pair(i, unfpdn->placecount));//映射（cpn->place的idx，unfpdn->place的下标）
            unfpdn->min_o->b_idx_vec.push_back(unfpdn->placecount);
            unfpdn->placecount++;//unf->place[i]从0开始保存；
            tmp_token++;
        }
        for (auto j = unfpdn->map_Plc_cpn2unf.lower_bound(i); j != unfpdn->map_Plc_cpn2unf.upper_bound(i); j++) {
            cout << j->first << "::"
                 << j->second << ";";
        }
    }

    cout << endl;
    //     initMarking.tid保存颜色


//    1-选择一个变迁t；
//    2-对于变迁t的每个前集库所，寻找被(p,c)标记的副本b，并放入颜色为c的token。若找不到返回第1步；
//    3-对于变迁t的所有绑定bp，是一个绑定元素（t，bp），
//    3.1- 对于 (t, bp) ，新建事件e ，并标记为t。
//    3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
//    4- 返回第1步。
//    int tmp_plc_id, tmp_num;
//    bool has_b;//判断是否有被(p,c)标记的副本//    vector<vector<pair<int, token>>> token_vector, binding_vector;
//    CTransition *tmp_t_cpn;
//    UTransition *tmp_t;
    for (int i = 0; i < cpn->get_transcount(); i++) {
        find_new_pe_by_t(i, unfpdn->min_o,-1);

        //    3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
        //    4- 返回第1步。

    }
}

void UNFOLD::fire() {
    auto pos = unfpdn->pe.begin();
//    for (auto i = unfpdn->pe.begin(); i != unfpdn->pe.end(); i++) {
//        auto tmp_pe = *i;
//        if (tmp_pe->t_idx < (*pos)->t_idx)
//            pos = i;
//    }
    PE *pe = *pos;

    for (auto i = 0; i < pe->cut->b_idx_vec.size(); i++) {
        cout << unfpdn->place[pe->cut->b_idx_vec[i]].id << ":" << unfpdn->place[pe->cut->b_idx_vec[i]].cpn_index << " ,";
    }
    cout << endl;

    CTransition *t = cpn->findT_byindex(pe->t_idx);
    auto T_producer = t->get_producer();
    Binding_unf *binding = pe->bindings;
    X *xs = pe->xs;

    UTransition *unf_t;

    cout << "t" << pe->t_idx << "is on fire" << endl;

    //新建事件e

    unf_t = &unfpdn->transition[unfpdn->transitioncount];
    unf_t->id = "E" + to_string(unfpdn->transitioncount);
    unf_t->cpn_index = pe->t_idx;
//        unf_t->binding = vec;
    //建立变迁前弧，输入库所后弧
//        auto x_mem = x;
//        while (x_mem->next) {
    BindingVariable(binding, cpn);


    for (auto j = 0; j < T_producer.size(); j++) {

        MultiSet ms;
        index_t b_idx;
        index_t idx = T_producer[j].idx;
        auto pp = cpn->findP_byindex(idx);
        cpn->CT2MS(T_producer[j].arc_exp, ms, pp->gettid(), pp->getsid());
        if(ms.getcolorcount()>1){
            for(auto i=ms.getmapTokens().begin();i!=ms.getmapTokens().end();i++) {
                for (auto k = pe->cut->b_idx_vec.begin(); k != pe->cut->b_idx_vec.end(); k++) {
                    Bucket bkt1, bkt2;
                    unfpdn->place[*k].token_record.getonlytoken()->getcolor(bkt1);
                    i->first->getcolor(bkt2);
                    if (unfpdn->place[*k].cpn_index == idx && bkt1 == bkt2)
                        b_idx = *k;
                }
                //前弧
                USArc usarc;
                usarc.idx = b_idx;
                unf_t->producer.push_back(usarc);
                //后弧
                usarc.idx = unfpdn->transitioncount;
                unfpdn->place[b_idx].consumer.push_back(usarc);
            }
        }
        if (ms.getcolorcount() == 1){
            for (auto k = pe->cut->b_idx_vec.begin(); k != pe->cut->b_idx_vec.end(); k++) {
                Bucket bkt1,bkt2;
                unfpdn->place[*k].token_record.getonlytoken()->getcolor(bkt1);
                ms.getonlytoken()->getcolor(bkt2);
                if (unfpdn->place[*k].cpn_index == idx &&bkt1 == bkt2)
                    b_idx = *k;
            }
        }
//            b_idx = unfpdn->findBidx_by_CplaceIdx_and_token(idx, ms.getonlytoken(), pe->cut);
        else {//弧为NULL的变量库所
            bool find=0;
            for (auto k = pe->cut->b_idx_vec.begin(); k != pe->cut->b_idx_vec.end(); k++) {
                if (unfpdn->place[*k].cpn_index == idx) {
                    find=1;
                    b_idx = *k;
                }
            }
            if(!find)
                cout<<"cant find pro in cut"<<endl;
//                b_idx = unfpdn->findBidx_by_CplaceIdx_and_token(idx, pp->getMultiSet().getonlytoken());
        }
//                b_idx = unfpdn->map_Plc_cpn2unf.find(idx)->second;
        //前弧
        USArc usarc;
        usarc.idx = b_idx;
        unf_t->producer.push_back(usarc);
        //后弧
        usarc.idx = unfpdn->transitioncount;
        unfpdn->place[b_idx].consumer.push_back(usarc);

        //删除token
//            unfpdn->place[b_idx].initMarking.MINUS(ms);
//            unfpdn->place[b_idx].initMarking.merge();
    }

    //建立变迁后弧，建立输出库所（条件），建立输出库所前弧
    auto T_consumer = t->get_consumer();
    auto tmp_placecount = unfpdn->placecount;
    for (unsigned int j = 0; j < T_consumer.size(); j++) {
        MultiSet ms;
        index_t idx = T_consumer[j].idx;
        auto pp = cpn->findP_byindex(idx);

        cpn->CT2MS(T_consumer[j].arc_exp, ms, pp->gettid(), pp->getsid());
        //CT2MS may have 0 count token
        ms.merge();
        //产生输出库所（条件）
        if (ms.getcolorcount() > 1) {
            auto mapTokens=ms.getmapTokens();
            for(auto k=mapTokens.begin();k!=mapTokens.end();k++){
                unfpdn->place[unfpdn->placecount].id = "B" + to_string(unfpdn->placecount);
                unfpdn->place[unfpdn->placecount].cpn_index = T_consumer[j].idx;
                unfpdn->place[unfpdn->placecount].token_record.generateFromToken((*k).first);
                unfpdn->place[unfpdn->placecount].token_record.setTokenCount((*k).second);

                unfpdn->map_Plc_cpn2unf.insert(
                        make_pair(idx, unfpdn->placecount));//映射（cpn->place的idx，unfpdn->place的下标）

                //产生后弧
                USArc usarc;
                usarc.idx = unfpdn->placecount;
                unf_t->consumer.push_back(usarc);

                //建立前弧
                usarc.idx = unfpdn->transitioncount;
                unfpdn->place[unfpdn->placecount].producer.push_back(usarc);
                unfpdn->placecount++;//unf->place[i]从0开始保存；
            }
            continue;
        }

        unfpdn->place[unfpdn->placecount].id = "B" + to_string(unfpdn->placecount);
        unfpdn->place[unfpdn->placecount].cpn_index = T_consumer[j].idx;
        if (ms.getcolorcount() == 1) {
            unfpdn->place[unfpdn->placecount].token_record=ms;
        }
        else {
            int b_idx;
            for (auto k = pe->cut->b_idx_vec.begin(); k != pe->cut->b_idx_vec.end(); k++) {
                if (unfpdn->place[*k].cpn_index == idx)
                    b_idx = *k;
            }
            unfpdn->place[unfpdn->placecount].token_record.generateFromToken(
                    unfpdn->place[b_idx].token_record.getonlytoken());
        }
        unfpdn->map_Plc_cpn2unf.insert(
                make_pair(idx, unfpdn->placecount));//映射（cpn->place的idx，unfpdn->place的下标）

        //产生后弧
        USArc usarc;
        usarc.idx = unfpdn->placecount;
        unf_t->consumer.push_back(usarc);

        //建立前弧
        usarc.idx = unfpdn->transitioncount;
        unfpdn->place[unfpdn->placecount].producer.push_back(usarc);
        unfpdn->placecount++;//unf->place[i]从0开始保存；
    }

    //建立前后弧完毕

    //判断cutoff
    CUT *cut;
    if(e_has_one_propro(unfpdn->transitioncount, unfpdn)){
        cut=get_cut_onepropro(unfpdn->transitioncount, unfpdn);
    }
    else
        cut = get_cut(unfpdn->transitioncount, unfpdn);
    unf_t->cut = cut;
    //debug+
    if(pe->t_idx==22)
        cout<<"stop";
    //debug-
    int t_idx_same_cut;
    if (is_cut_off(cut, unfpdn,t_idx_same_cut)) {
        merge_cut(pe->t_cut_idx,t_idx_same_cut,unfpdn);

        auto unf_t_pro=unf_t->producer;
        for(auto j=0;j<unf_t_pro.size();j++){
            auto b=&unfpdn->place[unf_t_pro[j].idx];
            b->consumer.clear();
        }
        auto unf_t_con=unf_t->consumer;
        for(auto j=0;j<unf_t_con.size();j++){
            auto b=&unfpdn->place[unf_t_con[j].idx];
            b->token_record.clear();
            b->producer.clear();
        }
        unf_t->producer.clear();
        unf_t->consumer.clear();
        unf_t->cut->b_idx_vec.clear();
        unfpdn->placecount = tmp_placecount;
        unfpdn->pe.erase(pos);
        return;
    }

    //删除token
//    for (auto j = 0; j < T_producer.size(); j++) {
//        MultiSet ms;
//        index_t b_idx;
//        index_t idx = T_producer[j].idx;
//        auto pp = cpn->findP_byindex(idx);
//        cpn->CT2MS(T_producer[j].arc_exp, ms, pp->gettid(), pp->getsid());
//        if (ms.getcolorcount() != 0) {
//            b_idx = unfpdn->findBidx_by_CplaceIdx_and_token(idx, ms.getonlytoken(),pe->cut);
//            unfpdn->place[b_idx].initMarking.MINUS(ms);
//            unfpdn->place[b_idx].initMarking.merge();
//        } else {//弧为NULL的变量库所
//            auto k = unfpdn->map_Plc_cpn2unf.lower_bound(idx);
//            for (; k != unfpdn->map_Plc_cpn2unf.upper_bound(idx); k++) {
//                if (unfpdn->place[k->second].initMarking.getcolorcount() == 0)
//                    continue;
//                b_idx = k->second;
//            }
////                b_idx = unfpdn->findBidx_by_CplaceIdx_and_token(idx, pp->getMultiSet().getonlytoken());
//            unfpdn->place[b_idx].initMarking.clear();
//        }
//    }

    //增token
//    for (unsigned int j = 0; j < T_consumer.size(); j++) {
//        MultiSet ms;
//        index_t idx = T_consumer[j].idx;
//        auto pp = cpn->findP_byindex(idx);
//
//        cpn->CT2MS(T_consumer[j].arc_exp, ms, pp->gettid(), pp->getsid());
//        //CT2MS may have 0 count token
//        ms.merge();
//        if (ms.getcolorcount() != 0) {
//            unfpdn->place[tmp_placecount].initMarking = ms;//保存token的值
//        } else {//弧为NULL的变量库所
//            unfpdn->place[tmp_placecount].initMarking = unfpdn->place[tmp_placecount].token_record;
//        }
//        tmp_placecount++;
//    }
    int e_cut_idx=unfpdn->transitioncount;
    unfpdn->transitioncount++;

    //    3.2- 事件e建立前后弧连接。每个绑定元素必须满足G（t），并且每个事件e的前集必须是co-set，否则不应生成e。
    //    4- 返回第1步。

    //在t的后置库所的后置变迁中，将使能变迁加入pe


    unfpdn->pe.erase(pos);
    for (int i = 0; i < cpn->get_transcount(); i++) {
        find_new_pe_by_t(i, cut,e_cut_idx);
    }
    unfpdn->cut_off.push_back(cut);

}

void UNFOLD::unfolding() {
    init();
    while (!unfpdn->pe.empty()) {
        fire();
    }
}


UNFOLD::UNFOLD() {
//    placecount = 0;
//    transitioncount = 0;
//    arccount = 0;
//    varcount = 0;
}

UNFOLD::~UNFOLD() {
//    delete [] place;
//    delete [] transition;
//    delete [] arc;
//    delete [] vartable;
}