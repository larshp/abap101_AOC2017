*&---------------------------------------------------------------------*
*& Report zaoc_01v1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaoc_01v1.

CLASS solver DEFINITION.
  PUBLIC SECTION.
    METHODS solve_captcha IMPORTING input_captcha         TYPE string
                          RETURNING VALUE(captcha_solved) TYPE i.
ENDCLASS.

CLASS solver IMPLEMENTATION.
  METHOD solve_captcha.
    DATA(in_len) = strlen( input_captcha ).
    DATA(sum) = 0.
    DATA(prev_dig) = input_captcha+0(1).
    DATA(offs) = 1.

    WHILE offs < in_len.
      IF input_captcha+offs(1) = prev_dig.
        ADD prev_dig TO sum.
      ENDIF.
      prev_dig = input_captcha+offs(1).
      ADD 1 TO offs.
    ENDWHILE.
    offs = strlen( input_captcha ) - 1.
    IF input_captcha+0(1) = input_captcha+offs(1).
      ADD input_captcha+offs(1) TO sum.
    ENDIF.
    captcha_solved = sum.
  ENDMETHOD.
ENDCLASS.

CLASS test_solver DEFINITION FOR TESTING RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA solver TYPE REF TO solver.
    METHODS setup.
    METHODS test_1122 FOR TESTING.
    METHODS test_1111 FOR TESTING.
    METHODS test_1234 FOR TESTING.
    METHODS test_91212129 FOR TESTING.
ENDCLASS.

CLASS test_solver IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT me->solver.
  ENDMETHOD.

  METHOD test_1111.
    DATA(captcha_solved) = solver->solve_captcha( '1111' ).
    cl_abap_unit_assert=>assert_equals( exp = 4 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_1122.
    DATA(captcha_solved) = solver->solve_captcha( '1122' ).
    cl_abap_unit_assert=>assert_equals( exp = 3 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_1234.
    DATA(captcha_solved) = solver->solve_captcha( '1234' ).
    cl_abap_unit_assert=>assert_equals( exp = 0 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_91212129.
    DATA(captcha_solved) = solver->solve_captcha( '91212129' ).
    cl_abap_unit_assert=>assert_equals( exp = 9 act = captcha_solved ).
  ENDMETHOD.

ENDCLASS.

DATA solver TYPE REF TO solver.
DATA puz_input TYPE string.

START-OF-SELECTION.

  CONCATENATE
  '18144568296689784866596347266193986531397687719431268499352125948651757961396717561854825453'
  '96318113437957491837321373218469774666839963164262237368442532611258528394646232336399175389'
  '56471777976912147841492151987159869475736689871887468786783996245337925516513359798471319759'
  '65677957755571358934665327487287312467771187981424785514785421781781976477326712674311994735'
  '94798738351669989791659543322829419875971595946957876673951847511877175578719623877234576294'
  '14773594834566411946853335283295811137885998436213263135923541678464664159435661831929462176'
  '89936174884493199368681514958669615226362538622898367728662941275658917124167353496334664239'
  '53975383543992966455288653888572723566254878352935361144123168161353544741794191147939155848'
  '14439331342838528795113954294891524359966692326812156277237235658722912968785283347733916266'
  '72491878762288953597499218397146685679387438634857358552943964839321464529237533868734473777'
  '75677568775935587851911342696919721182432589337681255679848332599412874324254489962521576585'
  '19239597981975628313138913717359737613844646853162733435418527585253181446813644921734651745'
  '12856618292785483181956548813344752352933634979165667651165776587656468598791994573513652324'
  '76468751534595962149334662382196555475561521985584296993226941483944688761373817456798951285'
  '77855663522859889919464361486528393915931787366249572149175277595742351336664619883558556133'
  '77789115472297915429318142824465141688559333787512328799783539285826471818279818457674417354'
  '33545439564443588938629769562537825661355891169514539777957652639724179518129432279768716832'
  '66964972566849438296666723411626564795635228921417149984778651149446712258982973386859586447'
  '28534192317628618817551492975251364233974374724968483637518876583946828819994321129556511537'
  '61925338198154439411218465558696465516419255235253462629599696876238882729487336271963661618'
  '27869769224451255519279692675913952921981557754349978277388627863415435245448223211121318154'
  '75829945625787561369956264826651461575948462782869972654343749617939132353399334744265286151'
  '17793159451485756366432929971343691472111974693215945628726788787877921881588319123685865695'
  '9258484139254446341'
  INTO  puz_input.

  CREATE OBJECT solver.

  DATA(result) = solver->solve_captcha( puz_input ).
  WRITE result.