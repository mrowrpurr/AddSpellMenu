.info
  .source "AddSpellMenu_Effect_Search.psc"
  .modifyTime 1627786773
  .compileTime 1627786817
  .user "mrowr"
  .computer "MROWR-PURR"
.endInfo
.userFlagsRef
  .flag conditional 1
  .flag hidden 0
.endUserFlagsRef
.objectTable
  .object AddSpellMenu_Effect_Search ActiveMagicEffect
    .userFlags 0
    .docString ""
    .autoState 
    .variableTable
      .variable ::ModQuest_var addspellmenu_questscript
        .userFlags 0
        .initialValue None
      .endVariable
    .endVariableTable
    .propertyTable
	  .property ModQuest AddSpellMenu_QuestScript auto
	    .userFlags 0
	    .docString ""
	    .autoVar ::ModQuest_var
	  .endProperty
    .endPropertyTable
    .stateTable
      .state
        .function GetState
          .userFlags 0
          .docString "Function that returns the current state"
          .return String
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
            RETURN ::state
          .endCode
        .endFunction
        .function GotoState
          .userFlags 0
          .docString "Function that switches this object to the specified state"
          .return None
          .paramTable
            .param newState String
          .endParamTable
          .localTable
            .local ::NoneVar None
          .endLocalTable
          .code
            CALLMETHOD onEndState self ::NoneVar
            ASSIGN ::state newState
            CALLMETHOD onBeginState self ::NoneVar
          .endCode
        .endFunction
        .function OnEffectStart 
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param target Actor
            .param caster Actor
          .endParamTable
          .localTable
            .local ::temp0 string
            .local ::temp1 bool
            .local searchQuery string
            .local ::temp2 actor
            .local ::temp3 bool
            .local spellsContainer Actor
            .local ::nonevar none
          .endLocalTable
          .code
            CALLSTATIC addspellmenu_menu_searchbox Show ::temp0  ;@line 6
            ASSIGN searchQuery ::temp0 ;@line 6
            COMPAREEQ ::temp1 searchQuery "" ;@line 7
            NOT ::temp1 ::temp1 ;@line 7
            JUMPF ::temp1 label3 ;@line 7
            CALLSTATIC addspellmenu_npcs GetTraderContainerNpc ::temp2 true ;@line 8
            ASSIGN spellsContainer ::temp2 ;@line 8
            PROPGET OnlyShowSpellsWithSpellTomes ::ModQuest_var ::temp3 ;@line 13
            CALLSTATIC addspellmenu_spellsearch SearchAllSpellsAndPopulateContainerWithMatches ::temp3 ::ModQuest_var searchQuery spellsContainer ::temp3 ;@line 9
            JUMPF ::temp3 label2 ;@line 9
            CALLSTATIC addspellmenu_menu_spellchooser Show ::nonevar spellsContainer ::ModQuest_var ;@line 14
            JUMP label1
            label2:
            STRCAT ::temp0 "No spells found matching \"" searchQuery ;@line 16
            STRCAT ::temp0 ::temp0 "\" which the player does not already have" ;@line 16
            CALLSTATIC debug MessageBox ::nonevar ::temp0 ;@line 16
            label1:
            JUMP label0
            label3:
            label0:
          .endCode
        .endFunction
      .endState
    .endStateTable
  .endObject
.endObjectTable