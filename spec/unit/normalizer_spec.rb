require 'spec_helper'

describe Normalizer do 

    it "normalizes strings" do 
      examples.each do |example|
        result = Normalizer.news_process(example[0])
        expect(result).to eq(example[1])
      end

  end

  def examples
    [
      ["Elena VÃ­boras defiende una PAC justa para los agricultores",
        "elena viboras defiende una pac justa para los agricultores"],
      
      ['relacionadas con laÂ  calidad, los mercados y tambiÃ©n en quÃ© punto se encuentra la reformaÂ  de la PolÃ­tica Agraria ComÃºn (PAC)',
       'relacionadas con la calidad, los mercados y tambien en que punto se encuentra la reforma de la politica agraria comun (pac)'],
      
      ['Para ello, ha sido invitada laÂ  consejera de Agricultura, Pesca y Desarrollo Rural de la Junta, ElenaÂ',
       'para ello, ha sido invitada la consejera de agricultura, pesca y desarrollo rural de la junta, elena'],
      
      ['VÃ­boras, quien ha coincidido', 'viboras, quien ha coincidido'],
      
      ['con el presidente de la DiputaciÃ³n, Francisco Reyes, en la necesidad de que la nueva PAC no suponga unaÂ',
       'con el presidente de la diputacion, francisco reyes, en la necesidad de que la nueva pac no suponga una'],

      ['segÃºn esteÂ  Ãºltimo, \"hay que defender a ultranza\". El presidente de la AdministraciÃ³n provincial,',
        'segun este ultimo, hay que defender a ultranza. el presidente de la administracion provincial,'],

      ['que ha sido elÂ  escenario de este encuentro', 
        'que ha sido el escenario de este encuentro'],

      ['en la que han participado mÃ¡s de unaÂ  veintena de representantes del sector oleÃ­cola jiennense',
        'en la que han participado mas de una veintena de representantes del sector oleicola jiennense'],
    
      ['haÂ  agradecido especialmente a la consejera \"su asistencia a esta reuniÃ³nÂ  que se celebra cuando ya ha empezado una campaÃ±a importante por',
        'ha agradecido especialmente a la consejera su asistencia a esta reunion que se celebra cuando ya ha empezado una campana importante por'],

      ['loÂ  que supone para el empleo y para que muchas familias puedan tenerÂ  ingresos que les permitan vivir durante el resto del aÃ±o\".',
        'lo que supone para el empleo y para que muchas familias puedan tener ingresos que les permitan vivir durante el resto del ano.'],

      ['Este foro tambiÃ©n tiene lugar coincidiendo con \"los ÃºltimosÂ  coletazos de un elemento que es fundamental para',
        'este foro tambien tiene lugar coincidiendo con los ultimos coletazos de un elemento que es fundamental para'],

      ['la provincia, laÂ  reforma de la PAC\". En este sentido, segÃºn ha informado laÂ  DiputaciÃ³n, Reyes ha subrayado',
        'la provincia, la reforma de la pac. en este sentido, segun ha informado la diputacion, reyes ha subrayado'],

      ['que \"aunque los agricultores sonÂ  conscientes de que lo mÃ¡s importante no son las ayudas comunitarias,Â  sino',
        'que aunque los agricultores son conscientes de que lo mas importante no son las ayudas comunitarias, sino'],

      ['que el aceite tenga un precio justo que les permita mantener laÂ  actividad en el territorio, mientras esas ayudas',
        'que el aceite tenga un precio justo que les permita mantener la actividad en el territorio, mientras esas ayudas'],

      ['existan hay queÂ  hacer una defensa a ultranza de las mismas, porque si EspaÃ±a noÂ  pierde en ese reparto de la PAC,',
        'existan hay que hacer una defensa a ultranza de las mismas, porque si espana no pierde en ese reparto de la pac,'],

      ['en ese sobre nacional, no puedenÂ  perder AndalucÃ­a, JaÃ©n ni el olivar\". Por su parte, la consejera de Agricultura,',
        'en ese sobre nacional, no pueden perder andalucia, jaen ni el olivar. por su parte, la consejera de agricultura,'],
    
      ['Pesca y DesarrolloÂ  Rural ha resaltado \"el interÃ©s de este consejo en el que ya se haÂ  reflexionado previamente',
        'pesca y desarrollo rural ha resaltado el interes de este consejo en el que ya se ha reflexionado previamente'],

      ['sobre la PAC, que estÃ¡ en su proceso final,Â  con el debate sobre su', 
        'sobre la pac, que esta en su proceso final, con el debate sobre su'],
    
      ['modelo de aplicaciÃ³n en EspaÃ±a, y losÂ  mecanismos de gestiÃ³n de mercados en esta nueva normativa.',
        'modelo de aplicacion en espana, y los mecanismos de gestion de mercados en esta nueva normativa.'],

      ['Entre otras cuestiones, la consejera ha lamentado que en estasÂ  negociaciones \"no se haya',
        'entre otras cuestiones, la consejera ha lamentado que en estas negociaciones no se haya'], 

      ['tocado la regulaciÃ³n de los mercados\", aÂ  pesar de que de ellos dependen \"el 70 por ciento',
        'tocado la regulacion de los mercados, a pesar de que de ellos dependen el 70 por ciento'],

      ['de los ingresos delÂ  sector agrÃ­cola\". AdemÃ¡s, ha hecho hincapiÃ© en que aÃºn',
        'de los ingresos del sector agricola. ademas, ha hecho hincapie en que aun'],

      ['quedan porÂ  cerrar cuestiones de gran relevancia para AndalucÃ­a, ya que Ã©stasÂ  podrÃ­an',
        'quedan por cerrar cuestiones de gran relevancia para andalucia, ya que estas podrian'],

      ['suponer una reducciÃ³n del volumen de ayudas que recibeÂ  actualmente la comunidad. VÃ­boras, segÃºn',
        'suponer una reduccion del volumen de ayudas que recibe actualmente la comunidad. viboras, segun'],

      ['ha indicado la Junta, se ha referido concretamenteÂ  a la posibilidad de que decrezca el montante',
        'ha indicado la junta, se ha referido concretamente a la posibilidad de que decrezca el montante'],

      ['total de ayudas directasÂ  que percibe la regiÃ³n (suma de ayudas acopladas y',
        'total de ayudas directas que percibe la region (suma de ayudas acopladas y'],

      ['desacopladas) siÂ  las subvenciones acopladas ganan importancia, ya que esto harÃ­a queÂ  las ayudas',
      'desacopladas) si las subvenciones acopladas ganan importancia, ya que esto haria que las ayudas'],

      ['desacopladas perdieran peso en el volumen global. ParaÂ  evitarlo, el Gobierno andaluz apuesta por adaptar',
        'desacopladas perdieran peso en el volumen global. para evitarlo, el gobierno andaluz apuesta por adaptar'],

      ['el futuro repartoÂ  de las ayudas acopladas para compensar el trasvase y que AndalucÃ­aÂ  continÃºe recibiendo asÃ­ el',
        'el futuro reparto de las ayudas acopladas para compensar el trasvase y que andalucia continue recibiendo asi el'],

      ['mismo total de ayudas directas. Por otro lado, ha recalcado que los simulacros de reparto de losÂ  fondos del segundo',
        'mismo total de ayudas directas. por otro lado, ha recalcado que los simulacros de reparto de los fondos del segundo'],

      ['pilar de la PAC, relativo al desarrollo rural,Â  podrÃ­an hacer perder a',
        'pilar de la pac, relativo al desarrollo rural, podrian hacer perder a'],

      ['la regiÃ³n una parte importante de estas ayudasÂ  en el marco 2014-2020. \"Estamos preocupados, porque nos jugamosÂ  mucho\", ha apostillado',
        'la region una parte importante de estas ayudas en el marco 2014-2020. estamos preocupados, porque nos jugamos mucho, ha apostillado']
    ]
  end

end




