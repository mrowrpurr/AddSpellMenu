.info
  .source "AddSpellMenu_Activator_Search.psc"
  .modifyTime 1627925133
  .compileTime 1627925257
  .user "mrowr"
  .computer "MROWR-PURR"
.endInfo
.userFlagsRef
  .flag conditional 1
  .flag hidden 0
.endUserFlagsRef
.objectTable
  .object AddSpellMenu_Activator_Search ObjectReference
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
        .function OnEquipped 
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param akActor Actor
          .endParamTable
          .localTable
            .local ::nonevar none
          .endLocalTable
          .code
            CALLSTATIC addspellmenu_menu_controls CloseInventoryMenu ::nonevar  ;@line 6
            CALLSTATIC addspellmenu_searchandlist SearchModsAndSpells ::nonevar ::ModQuest_var ;@line 7
          .endCode
        .endFunction
      .endState
    .endStateTable
  .endObject
.endObjectTable