MODULE Injetora
  !
  !************************************************************
  !               ServNews Robotica e Automacao               *
  !															*
  !Processo    : Manipulação de Peças de Injetora             *
  !Cliente     : AutoCom  (Taubaté-SP)                        *
  !Aplicacao   : Injetora                                     *
  !System ID   :                                              *
  !Robot Type  : IRC5  4400-45/1.96                           *
  !Product ID  :                                              *
  !Local       :                                              *
  !Criacao     : Marcelo Hasman, Paulo Vitor                  *
  !Data				 : 23/02/2012 11:02:40                  *
  !Alteração   :                                              *
  !www.servnews.com.br                 Phone: +55 12 39034106 *                                                     
  !************************************************************
  !
  !Rotinas presentes neste módulo:
  ! - Main Module
  ! - rMensagem
  ! - r_Calib
  ! - rCondInicial
  ! - rAutoReset
  ! - rControleGarra
  ! - rPosManutencao
  ! - rDescargaInjecao
  ! - rCargaSaida
  ! - rInspecao
  ! - rPrensa
  ! - rResfriamento
  ! - rHome
  ! - rHomeResfr
  ! - rHomePrensa
  ! - rHomeCargaSaida
  ! - rHomeInspecao
  ! - rHomeInjetora
  !===================================================================================================
  ! DADOS DE ROBTARGET
  !=================================================================================================== 
	CONST jointtarget jCalib:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget pSair7:=[[339.84,51.6,1619.5],[0.470149,0.465134,0.495129,0.563435],[0,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair6:=[[-256.98,527.45,1606.38],[0.544273,0.476426,0.47592,0.500286],[1,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair5:=[[-257,527.45,1606.38],[0.544282,0.47642,0.47591,0.500291],[1,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSensor3:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSensor2:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair4:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair3:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair2:=[[88.17,-527.33,633.25],[0.000389963,0.060643,-0.97885,-0.195385],[0,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSair1:=[[88.17,-527.34,633.26],[0.000400302,0.0606444,-0.97885,-0.195385],[0,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pExtra0:=[[551.68,20.92,1620.66],[0.719161,0.00861,-0.010047,0.694718],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pInj4:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pInj3:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pInj2:=[[-0.79,331.34,685.99],[0.000398936,0.0607099,-0.978832,-0.195455],[1,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pInj1:=[[5.84,310.47,377.44],[0.480189,0.431868,0.61185,-0.456672],[1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pInspecSensor:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget Descarte3:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget Descarte2:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget Descarte1:=[[551.68,20.92,1620.67],[0.719155,0.008622,-0.010053,0.694724],[0,0,-4,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget Calha11:=[[103.47,503.04,1786.65],[0.731707,0.629976,-0.210049,-0.15367],[1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pResfriamento:=[[-225.63,785.06,99.54],[0.110088,-0.653651,-0.742097,-0.0995609],[-1,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_ramp4:=[[1457.01,1416.25,659.36],[0.677442,-0.195491,0.707629,-0.046013],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pCargaSaida_OK:=[[1457.01,1416.25,659.36],[0.677442,-0.195491,0.707629,-0.046013],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_ramp3:=[[1457,1416.26,659.37],[0.677447,-0.195493,0.707624,-0.046019],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pCargaSaida_NOK:=[[2139.60,563.18,1126.71],[0.00211782,0.634004,0.773153,0.0164208],[0,-1,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomeCargaSaida:=[[682.92,247.78,1894.12],[0.713877,0.677816,0.13624,0.111285],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pCargaPrensa:=[[8.8,2046.67,274.72],[0.626139,-0.319104,0.620534,0.347938],[1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomePrensa:=[[1112.1,586.29,1165.15],[0.750292,-0.014387,0.66095,0.000697],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomeResfriam:=[[374.65,-1197.23,1553.76],[0.0650142,0.995597,0.0600379,0.0309248],[-1,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomeInjetora:=[[-105.99,583.23,1776.80],[0.510503,0.455837,0.449387,0.574152],[1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomeInspecao:=[[640.73,190.40,1911.06],[0.712017,0.700108,-0.00708416,0.0532097],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pSensor7:=[[276.32,374.04,1358.64],[0.19479,0.039405,0.148346,0.968761],[0,-1,-3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHome:=[[8.59,459.01,1488.79],[0.758658,-0.014914,0.075179,-0.646966],[1,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pManutInjetora:=[[-846.64,701.83,2004.14],[0.716295,0.665486,0.101522,0.183695],[1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pAproxima:=[[303.34,-1139.16,1442.54],[0.885388,0.454706,0.032278,0.091045],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pDescargaInjec:=[[15.73,335.64,387.07],[0.00140576,0.0682444,-0.976052,-0.206554],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_Enfri0:=[[1647.37,322.85,1426.26],[0.661096,-0.574636,0.296174,-0.380825],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_Sal0:=[[327.34,-1961.17,1183.34],[0.668458,0.737517,-0.080178,0.052963],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_prensa6:=[[268.07,2088.13,250.44],[0.626126,-0.319095,0.620542,0.347956],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_prensa5:=[[20.52,2088.17,378.68],[0.626115,-0.319105,0.620552,0.347949],[1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p_prensa4:=[[102.36,-1994.28,497.96],[0.012876,0.238505,-0.971055,-0.00191],[-1,-1,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPosSensor:=[[643.89,-33.69,1803.96],[0.102416,0.176791,0.545668,0.812713],[0,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pResf01:=[[-111.90,418.20,602.32],[0.594147,-0.515485,-0.433287,-0.439916],[-1,-1,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pResf02:=[[-143.50,628.96,634.92],[0.0134802,0.671565,0.738651,0.0566822],[-1,-1,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApxPRENSA_01:=[[1340.08,197.54,1901.20],[0.390306,0.28399,-0.611818,-0.62665],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApxPRENSA_02:=[[1340.08,197.54,1901.20],[0.390303,0.283991,-0.611818,-0.626651],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPRENSA:=[[1340.08,197.54,1901.20],[0.390303,0.28399,-0.611818,-0.626652],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApxPRENSA_03:=[[1340.08,197.54,1901.19],[0.390305,0.283991,-0.611818,-0.62665],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApx1:=[[1340.08,197.54,1901.19],[0.390301,0.283989,-0.611818,-0.626653],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApx110:=[[1616.57,-1047.89,277.39],[0.337434,0.470684,0.164278,-0.798503],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pPecaRuim:=[[1443.16,-940.68,1235.41],[0.0707121,0.745832,0.6439,0.155331],[-1,-1,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pApxInsp:=[[568.87,189.93,1813.43],[0.741505,0.629856,0.101974,0.207492],[0,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p100:=[[1245.52,579.24,1259.42],[0.750723,0.272453,0.457817,-0.390626],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p110:=[[1765.01,759.20,1210.28],[0.588198,0.371332,0.621771,-0.359913],[0,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p120:=[[2246.27,398.54,898.11],[0.668092,0.287374,0.439812,-0.526911],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p130:=[[1364.68,412.86,1164.77],[0.684545,0.269473,0.435685,-0.518615],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget p140:=[[2070.21,552.51,1298.42],[0.0545661,0.644075,0.762547,0.0266914],[0,-1,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pHomeInjetora10:=[[-481.94,611.73,1944.53],[0.729403,0.671739,0.0441113,0.121628],[1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  CONST robtarget pManutInjetora10:=[[-481.93,611.74,1944.54],[0.729402,0.67174,0.0441102,0.121625],[1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
   
  !===================================================================================================
  ! DADOS DE WORK OBJECT
  !=================================================================================================== 
  PERS wobjdata wobjInjetora:=[FALSE,TRUE,"",[[481.688,1876.5,982.947],[0.715794,0.00091392,-0.697937,-0.0228469]],[[0.00584126,-0.000596046,-0.00116229],[1,0.000104526,-1.71414E-05,1.96782E-05]]];
  PERS wobjdata wobjCargaSaida:=[FALSE,TRUE,"",[[1672.97,3.97673,962.577],[0.993954,-0.000867184,0.109789,5.94059E-05]],[[0.0650883,-0.000913977,0.000834465],[1,7.86829E-06,9.10027E-06,4.54626E-05]]];
  PERS wobjdata wobjInspecao:=[FALSE,TRUE,"",[[483.134,396.9,1620.78],[1,-0.000122,0.000122,0.000122]],[[0.004321,-0.00605,0.002623],[1,0.000122,5.1E-05,-0.000122]]];
  PERS wobjdata wobjResfriam:=[FALSE,TRUE,"",[[-397.075,-1417.74,617.16],[0.707211,2.32179E-05,3.81085E-05,-0.707002]],[[0.00166893,-0.00244379,-0.000238419],[1,8.54056E-06,-1.42641E-05,3.28767E-06]]];
  PERS wobjdata wobjPrensa:=[FALSE,TRUE,"",[[546.69,-1355.38,341.416],[0.707087,0.002294,0.001789,-0.707121]],[[-0.00751,-0.01055,0.028759],[1,-4.3E-05,-4.7E-05,-1E-06]]];
  PERS wobjdata wobjCarga:=[FALSE,TRUE,"",[[957.362,-171.488,1177.74],[0.990463,-0.023001,0.135816,0.002818]],[[-0.011742,-0.000551,0.001192],[1,-5E-06,-5.8E-05,-2.4E-05]]];
 
  !===================================================================================================
  ! DADOS DE FERRAMENTA
  !=================================================================================================== 
	PERS tooldata toolGARRA:=[TRUE,[[49.4969,-92.4834,345.45],[0.53732,0.449374,-0.506933,-0.502364]],[3,[130,0,390],[1,0,0,0],3,3,3]];
  !===================================================================================================
  ! DADOS BOOLEANOS
  !=================================================================================================== 
  VAR bool flag1:=FALSE;
  VAR bool flag2:=FALSE;
  VAR bool b_descargaok:=TRUE;
  VAR bool b_testok:=FALSE;
  VAR bool b_rearme:=TRUE;
  VAR bool b_pulsador:=FALSE;
  VAR bool b_CargaPrensa:=FALSE;
  VAR bool b_DescargaPrensa:=FALSE;
  VAR bool flagbolsa:=FALSE;
  VAR bool b_prensa:=FALSE;
  VAR bool fAutoReset:=FALSE;
  VAR bool fIntegridade:=FALSE;
  VAR bool fErrorExtrator:=FALSE;
  VAR bool fPecaNaoOK:=FALSE;

  !================================================================================== 
  ! Variaveis de interrupcoes
  !==================================================================================
  VAR intnum intPecaNaoOk:=0;

  !===================================================================================================
  ! DADOS NUMÉRICOS
  !=================================================================================================== 
  PERS num nTotalPecas:=0;
  VAR num nPosicaoZ:=0;
  VAR num nPosicaoY:=0;
  VAR num nPosicaoX:=0;
  VAR num nErrorExtrator:=0;
  PERS num nTempoGarra:=0.8;
  VAR num n_long:=0;
  PERS num nPecaRuim:=0;
  PERS num nPecaBoa:=0;
  PERS num contador:=1;
  !===================================================================================================
  ! DADOS DE INTERRUPÇÃO
  !=================================================================================================== 
  VAR intnum intno2:=0;
  VAR intnum intno1:=0;
  !===================================================================================================
  ! DADOS DE CARGA
  !=================================================================================================== 
  PERS loaddata load2:=[4,[-42,0,160],[1,0,0,0],0,0,0];
  !===================================================================================================
  ! DADOS DE STRING
  !=================================================================================================== 
  PERS string stMensagemstatus{14}:=["       Aguardando fechar a garra        ",
																		"       Aguardando abrir a garra         ",
																		"    Reserva    ",
																		" Aguardando injetora em modo automatico ",
																		"    Espera injetora ok para descarga    ",
																		"        Aguardando maquina aberta       ",
																		"Aguarda comando para descarga da maquina",
																		" Aguardando o final da extracao do molde",
																		"    Peca presa no molde ou no porao     ",
																		"    Executando a descagra da injetora   ",
																		"      Executando a inspecao da peca     ",
																		"    Executando o resfriamento da peca   ",
																		"       Executando descarga na rampa     ",
																		"     Executando sistema de autoreset    "];
  !===================================================================================================
  ! DADOS DE POSIÇÃO
  !=================================================================================================== 
  VAR pos posReset:=[0,0,0];
  !===================================================================================================
  ! DADOS DE CLOCK
  !=================================================================================================== 
   VAR clock ClkCiclo;
        CONST robtarget pCentro:=[[394.28,-86.52,1760.15],[0.342362,0.364866,-0.630969,-0.592907],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget pHomeInjetora20:=[[537.11,-439.00,1761.18],[0.451302,0.252153,-0.565136,-0.642937],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget pHomeInspecao10:=[[284.40,144.49,1881.72],[0.662576,0.578252,0.204562,0.429852],[0,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget pPosSensor10:=[[941.45,170.47,1784.46],[0.069019,-0.0570867,-0.57337,-0.814386],[0,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
  !===================================================================================================
  !
  !
  ! 
  !===================================================================================================
  ! ROTINA DE CONDIÇÕES INICIAIS
  !=================================================================================================== 
  PROC rCondInicial()
    ! Rotina que realiza as condicoes iniciais das variaveis do programa
    Reset do11_AvancaExtrator;
    Reset do10_AbrirGarra;
    Set do10_AbrirGarra;
    Reset do06_P_Incompleta;
    Reset do12_PecaOK;
    Reset do07_Emg_Stop;
    b_testok:=FALSE;
    b_prensa:=FALSE;
    b_descargaok:=TRUE;
    b_rearme:=TRUE;
	Return;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE MENSAGEM
  !===================================================================================================
  PROC rMensagem(
    num nIndexMensagem)

    TPErase;
    TPWrite "----------------AUTOCOM-----------------";
    TPWrite "                                        ";
    TPWrite "    Tempo Ciclo Total    = "\Num:=ClkRead(ClkCiclo);
    TPWrite "    Total Pecas Produzidas   = "\Num:=nTotalPecas;
	TPWrite "    Pecas Boas Produzidas  = "\Num:=nPecaBoa;
	TPWrite "    Pecas Ruins Produzidas = "\Num:=nPecaRuim;
    TPWrite "************ Status do robo ************";
    TPWrite stMensagemstatus{nIndexMensagem};
    TPWrite "     SERVNEWS ROBOTICA E AUTOMACAO      ";
    WaitTime 0.2;
  ENDPROC
  !=================================================================================================== 
	! ROTINA DE AUTORESET
 	!===================================================================================================
  PROC rAutoReset()
    rMensagem 14;
    !
    SoftDeact; !Desabilita o Soft Servo
    posReset:=CPos(\Tool:=toolGARRA\WObj:=wobj0); !Carrega posicao do Robô
    nPosicaoX:=posReset.x;
    nPosicaoY:=posReset.y;
    nPosicaoZ:=posReset.z;
  IF nPosicaoY<790 AND nPosicaoY>630 AND nPosicaoX<150 AND nPosicaoX>50 THEN
    MoveJ pHomeInjetora,v1500,fine,toolGARRA;
	MoveJ pApxInsp, v1000, z50, toolGARRA;
	rHomeCargaSaida;
	rPecaBoa;
	rHomeCargaSaida;
	MoveJ pHomeInjetora,v1500,fine,toolGARRA;
  ELSEIF nPosicaoY<2373 AND nPosicaoY>1380 AND nPosicaoX<660 AND nPosicaoX>-80 THEN
    ! Ponto de saida da injetora
	MoveL Offs(pDescargaInjec,0,0,150),v200,z1,toolGARRA\WObj:=wobjInjetora;
    ConfL\Off;
    MoveL pInj2,v1000,z1,toolGARRA\WObj:=wobjInjetora;
    MoveL pSair1,v1000,z1,toolGARRA\WObj:=wobjInjetora;
    MoveJ pSair2,v1000,z5,toolGARRA\WObj:=wobjInjetora;
    ConfL\On;
    MoveJ pHomeInjetora, v2000, z10, toolGARRA;
	MoveJ pApxInsp, v1000, z50, toolGARRA;
	rHomeCargaSaida;
	rPecaBoa;
	rHomeCargaSaida;
	MoveJ pHomeInjetora,v1500,fine,toolGARRA;
  ELSEIF nPosicaoY<-1148 AND nPosicaoY>-1640 AND nPosicaoX<-266 AND nPosicaoX>-482 THEN
    MoveL Offs(pResfriamento,0,0,500),v500,z20,toolGARRA\WObj:=wobjResfriam;
	MoveJ pHomeResfriam,v600,z20,toolGARRA\WObj:=wobj0;
    MoveJ pHomeCargaSaida,v1500,z5,toolGARRA;
    rPecaBoa;
    rHomeCargaSaida;
    MoveJ pHomeInjetora,v500,fine,toolGARRA;
  ELSEIF nPosicaoY<550 AND nPosicaoY>169 AND nPosicaoX<2220 AND nPosicaoX>1837 THEN
    MoveJ pCargaSaida_NOK, v300, z10, toolGARRA;
    WaitTime\InPos,0.5;
    rControleGarra\AbreGarra;
    MoveJ p140, v300, z20, toolGARRA;
	MoveJ p110, v1000, z20, toolGARRA;
    MoveJ pHomeCargaSaida, v1000, z5, toolGARRA\WObj:=wobj0;
    MoveJ pHomeInjetora,v1000,fine,toolGARRA;
  ELSEIF nPosicaoY<560 AND nPosicaoY>-180 AND nPosicaoX<1356 AND nPosicaoX>900 THEN
    rHomeCargaSaida;
    rPecaBoa;
    rHomeCargaSaida;
    MoveJ pHomeInjetora,v1500,fine,toolGARRA;
  ELSEIF nPosicaoY<-696 AND nPosicaoY>-1414 AND nPosicaoX<1830 AND nPosicaoX>1275 THEN
    rPecaRuim;
    MoveJ pHomeCargaSaida,v1500,z5,toolGARRA;
    MoveJ pHomeInjetora,v1500,fine,toolGARRA;
  ELSEIF nPosicaoY<846 AND nPosicaoY>430 AND nPosicaoX<-600 AND nPosicaoX>-915 THEN
    MoveJ pManutInjetora,v300,z1,toolGARRA;
    MoveJ pManutInjetora10, v300, fine, toolGARRA;
    MoveJ pHomeInjetora,v500,fine,toolGARRA;
  ELSEIF nPosicaoY<-100 AND nPosicaoY>-742 AND nPosicaoX<1406 AND nPosicaoX>990 THEN
    rHomeInspecao;
    rHomeCargaSaida;
    rPecaBoa;
    rHomeCargaSaida;
	MoveJ pHomeInjetora,v500,fine,toolGARRA;
  ELSEIF nPosicaoY<384 AND nPosicaoY>-430 AND nPosicaoX<800 AND nPosicaoX>394 THEN
    MoveJ pCentro, v600, z1, toolGARRA;
    rHomeCargaSaida;
    rPecaBoa;
    rHomeCargaSaida;
	MoveJ pHomeInjetora,v500,fine,toolGARRA;
  ELSE
    TPErase;
	TPWrite"Robo fora da área mapeada!!";
	TPWrite"O robo pode ir para Home? ";
	TPReadFK reg1, " CUIDADO RISCO DE COLISÂO!!! ","SIM", stEmpty, stEmpty, stEmpty, "NAO";
   TEST reg1
	CASE 1: 
	MoveJ pCentro, v600, z1, toolGARRA;
	rHomeCargaSaida;
    rPecaBoa;
    rHomeCargaSaida;
	MoveJ pHomeInjetora,v500,fine,toolGARRA;
	CASE 5: 
	TPErase;
	TPWrite "";
	TPWrite " Passe para modo manual e movimente o robo ";
	TPwrite " para proximo do centro da celula";
	Stop;
	MoveJ pCentro, v600, z1, toolGARRA;
	rHomeCargaSaida;
    rPecaBoa;
    rHomeCargaSaida;
	MoveJ pHomeInjetora,v500,fine,toolGARRA;
   ENDTEST
  ENDIF
    TPErase;
	TPWrite " ";
	TPWrite " ";
	TPReadFK contador, "Deseja zerar o contador de Pecas","SIM", stEmpty, stEmpty, stEmpty, "NAO";
	TEST contador
	CASE 1: 
	nPecaRuim:=0;
    nPecaBoa:=0;
	CASE 5:
	TPErase;
	TPWrite " A Contagem de Pecas foi mantida ";
	WaitTime 1;
	ENDTEST
  ENDPROC
  !===================================================================================================
  ! ROTINA DE DESCARGA DA INJEÇÃO
  !=================================================================================================== 
  PROC rDescargaInjecao()
    !
    ! Rotina de descarga da injetora
    !
    rMensagem 10;
    MoveJ pSair2, v2500, z5, toolGARRA\WObj:=wobjInjetora;
    MoveL pInj2, v2000, z5, toolGARRA\WObj:=wobjInjetora;
    MoveL Offs(pDescargaInjec,0,0,150),v1000,z5,toolGARRA\WObj:=wobjInjetora;
    MoveL Offs(pDescargaInjec,0,0,40), v500, z1, toolGARRA\WObj:=wobjInjetora;
    MoveL pDescargaInjec, v50, z50, toolGARRA\WObj:=wobjInjetora;
    WaitUntil\InPos,TRUE;
    rControleGarra\FechaGarra;
    WaitTime 1;
    SoftAct 1,100;
    SoftAct 4,20;
    SoftAct 2,50;
    SoftAct 3,50;
    SoftAct 5, 5;
    SoftAct 6,20;
    Set do11_AvancaExtrator;
    TPErase;
    TPWrite "Aguardando Avancar Extrator";
    WaitUntil di06_ExtratorAvan = 1\MaxTime:=15\TimeFlag:=flag1;
    ! Aguarda sinal de extrator avancado
    IF flag1=TRUE THEN
      rControleGarra\AbreGarra;
      b_descargaok:=FALSE;
	ELSEIF flag1=FALSE THEN
	  b_descargaok:=TRUE;
    ENDIF
    SoftDeact;
    MoveL Offs(pDescargaInjec,0,0,150), v600, z1, toolGARRA\WObj:=wobjInjetora;
    ! Ponto de saida da injetora
    ConfL\Off;
    MoveL pInj2,v1000,z1,toolGARRA\WObj:=wobjInjetora;
    MoveL pSair1, v2500, z1, toolGARRA\WObj:=wobjInjetora;
    MoveJ pSair2, v2500, z5, toolGARRA\WObj:=wobjInjetora;
    ConfL\On;
    MoveJ pHomeInjetora, v800, fine, toolGARRA;
    WaitTime\Inpos,0.1;
    Reset do11_AvancaExtrator;
    PulseDO\PLength:=6,do04_FecharPorta;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE INSPEÇÃO
  !=================================================================================================== 
  PROC rInspecao()
    !
    ! Rotina que efetua a inspecao da peca verificando se ficou partes no molde
    !
    b_testok:=FALSE;
    MoveJ pHomeInspecao, v600, z40, toolGARRA\WObj:=wobj0;
    MoveL pPosSensor, v600, fine, toolGARRA\WObj:=wobj0;
    MoveL pPosSensor10, v600, fine, toolGARRA;
    ! Posicao de verificacao da peca
    ! Aguarda condicao de peca por 1 segundo
    WaitDI di12_SensorBolsa, 1\MaxTime:=4\TimeFlag:=flagbolsa;
  IF flagbolsa = FALSE AND fPecaNaoOK = FALSE THEN
    ! Libera maquina para injecao
    WaitUntil\InPos,TRUE;
    PulseDO\PLength:=3,do12_PecaOK;
    b_testok:=TRUE;
  ELSE
    IF flagbolsa = FALSE THEN
     WaitUntil\InPos,TRUE;  
     PulseDO\PLength:=3, do12_PecaOK;
    ENDIF
    IF flagbolsa = TRUE AND fPecaNaoOK=TRUE THEN
    ! Tratamento em caso de peca nao OK
    TPErase;
    TPWrite "Peca incompleta!!!!! ";
    TPWrite " ";
    TPWrite " Pressione o botao para rearme ";
    PulseDO\PLength:=1,do06_P_Incompleta;
    Reset do12_PecaOK;
    fPecaNaoOK:=FALSE;
    ENDIF
    b_rearme:=TRUE;
  ENDIF
    TPErase;
    MoveL Offs(pPosSensor,-200,0,0), v300, z40, toolGARRA\WObj:=wobj0;
    MoveJ pHomeInspecao, v500, z40, toolGARRA\WObj:=wobj0;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE RESFRIAMENTO
  !===================================================================================================  !
  PROC rResfriamento()
    !
    ! Rotina de resfriamento apos inspecao
    !
    rMensagem 12;
    MoveJ pHomeResfriam, v1000, z20, toolGARRA\WObj:=wobj0;
    MoveL Offs(pResfriamento,0,0,500), v300, z20, toolGARRA\WObj:=wobjResfriam;
    MoveL pResfriamento, v300, z20, toolGARRA\WObj:=wobjResfriam;
    WaitTime 8;
    MoveL Offs(pResfriamento,0,0,500), v200, z20, toolGARRA\WObj:=wobjResfriam;
    MoveJ pResf01, v100, z20, toolGARRA\WObj:=wobjResfriam;
    WaitTime 1;
    MoveJ pResf02, v200, z20, toolGARRA\WObj:=wobjResfriam;
    MoveL Offs(pResfriamento,0,0,500),v300,z20,toolGARRA\WObj:=wobjResfriam;
    WaitTime 1;
    MoveJ pHomeResfriam, v800, z20, toolGARRA\WObj:=wobj0;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE POSICIONAMENTO DE MANUTENÇÃO
  !=================================================================================================== 
  PROC rPosManutencao()
    !
    ! Rotina de movimento para lateral da injetora
    !
    MoveJ pHomeInjetora,v300,z1,toolGARRA;
    MoveJ pManutInjetora10, v300, z1, toolGARRA;
    MoveJ pManutInjetora,v300,z1,toolGARRA;
    MoveJ pManutInjetora10, v300, z1, toolGARRA;
    MoveJ pHomeInjetora,v300,z1,toolGARRA;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE CARREGAR A SAÍDA (DEPOSITO DE PEÇAS)
  !=================================================================================================== 
  PROC rCargaSaida()
    ! Esta rotina não esta sendo utilizada no momento!!!
    ! Deposita pecas ruins!!
    !
    MoveJ pHomeCargaSaida, v2500, z10, toolGARRA\WObj:=wobj0;
    MoveJ [[1301.78,354.36,1193.11],[0.718579,0.287284,0.392052,-0.497401],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]], v600, z5, toolGARRA;
    MoveL Offs(pCargaSaida_NOK,-300,0,200),v4000,z20,toolGARRA\WObj:=wobjCargaSaida;
    MoveL Offs(pCargaSaida_NOK,0,0,100), v2000, z10, toolGARRA\WObj:=wobjCargaSaida;
    MoveL pCargaSaida_NOK, v300, z10, toolGARRA\WObj:=wobjCargaSaida;
    WaitTime\InPos,0.5;
    rControleGarra\AbreGarra;
    MoveL Offs(pCargaSaida_NOK,0,0,200),v800,z20,toolGARRA\WObj:=wobjCargaSaida;
    MoveL Offs(pCargaSaida_NOK,-150,0,200),v800,z20,toolGARRA\WObj:=wobjCargaSaida;
    WaitTime 1;
    MoveJ pHomeCargaSaida,v800,z5,toolGARRA\WObj:=wobj0;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE PRENSA
  !=================================================================================================== 
  PROC rPrensa()
  !
  !Esta rotina não esta sendo utilizada no momento
  !
    TPWrite "Peca OK";
    WaitUntil di15_PrensaPronta = 1\MaxTime:=1\TimeFlag:=flag2;
  IF flag2=TRUE THEN
    TPErase;
    TPWrite " ";
    TPWrite "Prensa não está pronta";
    rPecaBoa;
    rHomeCargaSaida;
    RETURN;
  ENDIF
   ! Pontos na prensa não marcados
   ! só retirar comentario quando colocar a prensa
   ! em funcionamento com o robo e marcar os pontos
    !MoveJ pApxPRENSA_01, v200, z50, toolGARRA;
    !MoveL pPRENSA, v600, fine, toolGARRA;
    !rControleGarra\AbreGarra;
    !WaitTime 0.5;
    !MoveL pApxPRENSA_03, v80, fine, toolGARRA;
    !TPErase;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE CALIBRAÇÃO 
  !=================================================================================================== 
  PROC r_Calib()
    MoveAbsJ jCalib,v400,fine,toolGARRA;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE CONTROLE DE GARRA
  !=================================================================================================== 
  PROC rControleGarra(
    \switch AbreGarra
    \switch FechaGarra)
   !
   ! Rotina de controle da garra
   !
  IF Present(AbreGarra) THEN
    Set do10_AbrirGarra;
    WaitTime 0.3;
    GripLoad load0;
    RETURN;
  ENDIF
  IF Present(FechaGarra) THEN
    Reset do10_AbrirGarra;
    WaitTime 0.3;
    GripLoad load2;
    WaitTime 1;
    RETURN;
  ENDIF
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME GERAL
  !=================================================================================================== 
  PROC rHome()
    !
    ! Rotina de home geral da celula
    !
    AccSet 100,50;
    MoveJ pHome,v1000,fine,toolGARRA;
    AccSet 100,100;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME DA INJETORA
  !=================================================================================================== 
  PROC rHomeInjetora()
    !
    ! Rotina de home da injetora
    !
    AccSet 100, 100;
    MoveJ pHomeInjetora, v1500, fine, toolGARRA;
    AccSet 100,100;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME INSPEÇÃO
  !=================================================================================================== 
  PROC rHomeInspecao()
    !
    ! Rotina de home da inspecao
    !
    MoveJ pHomeInspecao,v800,fine,toolGARRA\WObj:=wobj0;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME DO RESFRIAMENTO
  !=================================================================================================== 
  PROC rHomeResfr()
    !
    ! Rotina de home do Resfriamento
    !
    MoveJ pHomeResfriam, v1500, fine, toolGARRA;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME DA PRENSA
  !=================================================================================================== 

  PROC rHomePrensa()
    !
    ! Rotina de home da Prensa
    !
    MoveJ pHomePrensa,v300,fine,toolGARRA\WObj:=wobjPrensa;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA DE HOME DA CARGA SAÍDA
  !=================================================================================================== 
  PROC rHomeCargaSaida()
    !
    ! Rotina de home da Carga saída
    !
    MoveJ pHomeCargaSaida, v2500, z10, toolGARRA\WObj:=wobj0;
    RETURN;
  ENDPROC
  !===================================================================================================
  ! ROTINA ROTINA DE PEÇA BOA (rotina temporária)
  !=================================================================================================== 
	PROC rPecaBoa()
    !
    ! Deposito temporario de Pecas boas!!
    !
    ConfL\Off;
    MoveJ p100, v800, z20, toolGARRA;
    MoveJ p110, v800, z20, toolGARRA;
    MoveJ p140, v1000, z20, toolGARRA;
    MoveJ pCargaSaida_NOK, v300, z1, toolGARRA;
    WaitTime\InPos, 0.1;
    rControleGarra\AbreGarra;
    WaitTime 0.5;
  	nPecaBoa := nPecaBoa + 1;
  	MoveJ p140, v2500, z20, toolGARRA;
	  MoveJ p110, v3000, z20, toolGARRA;
    WaitTime 1;
    MoveJ pHomeCargaSaida, v2500, z5, toolGARRA\WObj:=wobj0;
    ConfL\On;
    RETURN;
	ENDPROC
  
  !===================================================================================================
  ! ROTINA DE PECA RUIM (rotina temporária)
  !=================================================================================================== 
	PROC rPecaRuim()
    !
    ! Deposito temporario de pecas ruins!!
    !
    ConfL\Off;
    MoveJ Offs(pPecaRuim,-500,0,800), v1000, z50, toolGARRA;
    MoveJ Offs(pPecaRuim,0,0,400), v1000, z50, toolGARRA;
    MoveJ pPecaRuim, v500, fine, toolGARRA;
    WaitUntil\InPos, TRUE;
    rControleGarra\AbreGarra;
    WaitTime 1.5;
    WaitTime\InPos, 1;
    nPecaRuim := nPecaRuim + 1;
    MoveJ Offs(pPecaRuim,0,0,400), v1000, z50, toolGARRA;
    MoveJ Offs(pPecaRuim,-500,500,800), v1000, z50, toolGARRA;
    ConfL\On;
    fPecaNaoOK:=FALSE;
	ENDPROC
	
    TRAP trapPecaNaoOk
        !
        fPecaNaoOK:=TRUE;
        
    ENDTRAP
  !===================================================================================================
  ! ROTINA PRINCIPAL
  !=================================================================================================== 
  PROC main()
    !
    ! Programa de controle da celula
    !
  IF fAutoReset=FALSE THEN
    !
    CONNECT intPecaNaoOk WITH trapPecaNaoOk;
    ISignalDI di16_PecaRuim,1,intPecaNaoOk;
    TPErase;
    rAutoReset;
    rCondInicial;
    fAutoReset:=TRUE;
    rHomeInjetora;
  ENDIF
    rMensagem 4;
    Set do05_Prot_Fechada;
    WaitDI di01_InjAUTO,1;
    ClkReset ClkCiclo;
    ClkStart ClkCiclo;
    rControleGarra\AbreGarra;
    rHomeInjetora;
    rMensagem 5;
    WaitUntil di11_2FaseMoldeFecha = 1;
    rMensagem 6;
  WHILE di03_MoldeAberto=0 DO
   TPErase;
   TPWrite "Aguardando Abrir Molde!";
   WaitTime\Inpos, 1;
  ENDWHILE
    rMensagem 7;
    WaitUntil di06_ExtratorAvan = 0 AND di05_ExtratorRec = 1;
    rDescargaInjecao;
    rHomeInjetora;
  IF b_descargaok=FALSE THEN
    rPosManutencao;
    b_descargaok:=TRUE;
  ELSE
    MoveJ pApxInsp, v600, z50, toolGARRA;
    rHomeInspecao;
    rInspecao;
  IF b_testok THEN
    !
	  rHomeResfr;
    rResfriamento;
	  rHomeResfr;
    rHomeCargaSaida;
  	rPrensa;
  ELSE
    rHomeResfr;
    rResfriamento;
	  rHomeResfr;
    rPecaRuim;
    rHomeInspecao;
  ENDIF
 ENDIF
    rHomeInjetora;
    ClkStop ClkCiclo;   
 ENDPROC
   
ENDMODULE
