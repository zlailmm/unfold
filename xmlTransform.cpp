//
// Created by ccisman on 2021/9/29.
//

#include<string>
#include<stack>
#include<vector>
#include<iostream>
#include "BA/tinyxml.h"
#include "cpn.h"

TiXmlElement* statementTransform(TiXmlElement *statementNode, CPN *cpn){
    vector<string> Ps,Ts;

    unsigned short row = atoi(statementNode->GetText());
    cpn->getRowRelatedPT(row,Ps,Ts);
    if(Ts.size() == 0)
        throw "statement property没有找到相应的变迁!";
    TiXmlElement *newNode = new TiXmlElement("is-fireable");
    TiXmlElement *newTNode = new TiXmlElement("transition");
    newNode->LinkEndChild(newTNode);
    TiXmlText *text = new TiXmlText(Ts[0].c_str());
    newTNode->LinkEndChild(text);
    for(int i=1;i<Ts.size();i++) {
        TiXmlElement *newElement = new TiXmlElement("is-fireable");
        TiXmlElement *newTNode = new TiXmlElement("transition");
        newElement->LinkEndChild(newTNode);
        TiXmlText *newText = new TiXmlText(Ts[i].c_str());
        newTNode->LinkEndChild(newText);

        TiXmlElement *conjunctionNode = new TiXmlElement("conjunction");
        conjunctionNode->LinkEndChild(newNode);
        conjunctionNode->LinkEndChild(newElement);
        newNode = conjunctionNode;
    }
    return newNode;
}

void variableTransform(TiXmlElement *variableNode, CPN *cpn){

}

void changeProgramXML2PDNetXML(std::string filename, CPN *cpn){
    std::vector<TiXmlElement*> statements,variables;
    TiXmlDocument *doc = new TiXmlDocument(filename.c_str());
    if (!doc->LoadFile()) {
        std::cerr << doc->ErrorDesc() << std::endl;
    }
    TiXmlElement *root = doc->RootElement();

    std::stack<TiXmlElement*> elementStack;
    elementStack.push(root);

    while(!elementStack.empty()){
        TiXmlElement *current = elementStack.top();
        elementStack.pop();
        std::string value = current->Value();
        if (value == "statement")
            statements.push_back(current);
        else if (value == "variable")
            variables.push_back(current);
        auto element = current->FirstChildElement();
        if(element) {
            while (element) {
                elementStack.push(element);
                element = element->NextSiblingElement();
            }
        }
    }

    for(int i=0;i<statements.size();i++) {
        TiXmlElement *newNode = statementTransform(statements[i], cpn);
        auto parent = statements[i]->Parent();
        parent->ReplaceChild(statements[i],*newNode);
    }

    for(int i=0;i<variables.size();i++)
        variableTransform(variables[i],cpn);

    doc->SaveFile("newXML.xml");
}