*&---------------------------------------------------------------------*
*& Report zaoc_01av1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaoc_01av1.

CLASS solver DEFINITION.
  PUBLIC SECTION.
    METHODS solve_captcha IMPORTING input_captcha         TYPE string
                          RETURNING VALUE(captcha_solved) TYPE i.
ENDCLASS.

CLASS solver IMPLEMENTATION.
  METHOD solve_captcha.
    DATA(in_len) = strlen( input_captcha ) - 1.
    DATA(steps) = in_len / 2.
    DATA(inputx) = input_captcha && input_captcha(steps).

    DATA(offs) = 0.
    DATA(pair) = inputx+steps(1).

    WHILE offs <= in_len.
      IF inputx+offs(1) = pair.
        ADD pair TO captcha_solved.
      ENDIF.
      IF offs = in_len.
        EXIT.
      ENDIF.
      ADD 1 TO steps.
      pair = inputx+steps(1).
      ADD 1 TO offs.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.

CLASS test_solver DEFINITION FOR TESTING RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA solver TYPE REF TO solver.
    METHODS setup.
    METHODS test_1212 FOR TESTING.
    METHODS test_1221 FOR TESTING.
    METHODS test_123425 FOR TESTING.
    METHODS test_123123 FOR TESTING.
    METHODS test_12131415 FOR TESTING.
ENDCLASS.

CLASS test_solver IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT me->solver.
  ENDMETHOD.

  METHOD test_1212.
    DATA(captcha_solved) = solver->solve_captcha( '1212' ).
    cl_abap_unit_assert=>assert_equals( exp = 6 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_1221.
    DATA(captcha_solved) = solver->solve_captcha( '1221' ).
    cl_abap_unit_assert=>assert_equals( exp = 0 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_123425.
    DATA(captcha_solved) = solver->solve_captcha( '123425' ).
    cl_abap_unit_assert=>assert_equals( exp = 4 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_123123.
    DATA(captcha_solved) = solver->solve_captcha( '123123' ).
    cl_abap_unit_assert=>assert_equals( exp = 12 act = captcha_solved ).
  ENDMETHOD.

  METHOD test_12131415.
    DATA(captcha_solved) = solver->solve_captcha( '12131415' ).
    cl_abap_unit_assert=>assert_equals( exp = 4 act = captcha_solved ).
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

  CONCATENATE
  '1814456829668978486659634726619398653139768771943126849935212594865175279613967175618548254'
  '5396318113437957491837321373218469774666839963164262237368442532611258528394646232336399175'
  '3895647177797691214784149215198715986947573668987188746878678399624533792551651335979847131'
  '9759656779577555713589346653274872873124677711879814247855147854217817819764773267126743119'
  '9473594798738351669989791659543322829419875971595946957876673951847511877175578719623877234'
  '5762941477359483456641194685333528329581113788599843621326313592354167846466415943566183192'
  '9462176899361748844931993686815149586696152263625386228983677286629412756589171241673534963'
  '3466423953975383543992966455288653888572723566254878352935361144123168161353544741794191147'
  '9391558481443933134283852879511395429489152435996669232681215627723723565872291296878528334'
  '7733916266724918787622889535974992183971466856793874386348573585529439648393214645292375338'
  '6873447377775677568775935587851911342696919721182432589337681255679848332599412874324254489'
  '9625215765851923959798197562831313891371735973761384464685316273343541852758525318144681364'
  '4921734651745128566182927854831819565488133447523529336349791656676511657765876564685987919'
  '9457351365232476468751534595962149334662382196555475561521985584296993226941483944688761373'
  '8174567989512857785566352285988991946436148652839391593178736624957214917527759574235133666'
  '4619883558556133777891154722979154293181428244651416885593337875123287997835392858264718182'
  '7981845767441735433545439564443588938629769562537825661355891169514539777957652639724179518'
  '1294322797687168326696497256684943829666672341162656479563522892141714998477865114944671225'
  '8982973386859586447285341923176286188175514929752513642339743747249684836375188765839468288'
  '1999432112955651153761925338198154439411218465558696465516419255235253462629599696876238882'
  '7294873362719636616182786976922445125551927969267591395292198155775434997827738862786341543'
  '5245448223211121318154758299456257875613699562648266514615759484627828699726543437496179391'
  '3235339933474426528615117793159451485756366432929971343691472111974693215945628726788787877'
  '9218815883191236858656959258484139254446341' INTO puz_input.


  CREATE OBJECT solver.

  DATA(result) = solver->solve_captcha( puz_input ).
  WRITE result.