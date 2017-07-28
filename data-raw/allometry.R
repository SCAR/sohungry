library(dplyr)

## notes
## define class of allometric measurements
## each has units and description
## e.g. "otolith length" (mm)
##
## equations can then be defined in terms of classes
## function(...) {
##   iv <- list(...)
##   LRL <- iv[[class(iv)=="whichever class we are looking for"]]

## no, better, ... vars coming in should be a df/tibble, and then check type by column

## define each unique equation, along with its nominal taxon and reference
## cephalopod equations from Xavier & Cherel
alleq_xc <- function(id) {
    switch(id,
           ## Ancistrocheirus lesueuri
           ## ML=-41.3+40.75LRL ; ln M=-0.194+3.56ln LRL (n=23 for ML, n=21 for M) (Clarke 1986)
           "138747_ML_Clar1986"=list(taxon_name="Ancistrocheirus lesueuri",
                                     taxon_aphia_id=138747,
                                     equation=function(...)-41.3+40.75*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=23,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138747_mass_Clar1986"=list(taxon_name="Ancistrocheirus lesueuri",
                                       taxon_aphia_id=138747,
                                       equation=function(...)exp(-0.194+3.56*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=21,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           ## Architeuthis dux
           ## ML=-55.6+59.31LRL ; ln M=-1.773+4.57ln LRL (n=11 for ML; n=9 for M) (Clarke 1986)
           ## For relationships between ML and LRL, ML=10((LRL/11.2)+1.723214286) (n=43) might be
           ## better (Roeleveld 2000) with ML= mantle length (in mm), M= mass (in g) and LRL=
           ## lower rostral length (in mm).
           "342218_ML_Clar1986"=list(taxon_name="Architeuthis dux",
                                     taxon_aphia_id=342218,
                                     equation=function(...)-55.6+59.31*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=11,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342218_mass_Clar1986"=list(taxon_name="Architeuthis dux",
                                       taxon_aphia_id=342218,
                                       equation=function(...)exp(-1.773+4.57*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=9,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342218_ML_Roel2000"=list(taxon_name="Architeuthis dux",
                                     taxon_aphia_id=342218,
                                     equation=function(...)10^((.../11.2)+1.723214286),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=43,
                                     reference="Roeleveld (2000) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           ## Bathyteuthis abyssicola
           ## ML=1.68+51.59LRL; ln M=2.855+3.38ln LRL (n=17 for both ML and M) (Clarke 1986)
           "138848_ML_Clar1986"=list(taxon_name="Bathyteuthis abyssicola",
                                     taxon_aphia_id=138848,
                                     equation=function(...)1.68+51.59*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=17,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138848_mass_Clar1986"=list(taxon_name="Bathyteuthis abyssicola",
                                       taxon_aphia_id=138848,
                                       equation=function(...)exp(2.855+3.38*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=17,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Batoteuthis skolops (no specific equations)
           ## May use formulas for close families
           ## ML=11.4+24.46LRL; ln M=-0.241+2.7ln LRL (n=23 for ML, n=14 for M) (Clarke 1986),
           ## based on Chiroteuthis spp. formulas
           "137777_ML_Clar1986"=list(taxon_name="Chiroteuthis",
                                     taxon_aphia_id=137777,
                                     equation=function(...)11.4+24.46*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=23,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "137777_mass_Clar1986"=list(taxon_name="Chiroteuthis",
                                     taxon_aphia_id=137777,
                                     equation=function(...)exp(-0.241+2.7*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=14,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           ## ML=-1.8+29.08LRL ; ln M=0.184+2.88ln LRL (n=47 for ML, n=45 for M) (Clarke 1986),
           ## based on Mastigoteuthis spp. formulas
           "138168_ML_Clar1986"=list(taxon_name="Mastigoteuthis",
                                     taxon_aphia_id=138168,
                                     equation=function(...)-1.8+29.08*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=47,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138168_mass_Clar1986"=list(taxon_name="Mastigoteuthis",
                                     taxon_aphia_id=138168,
                                     equation=function(...)exp(0.184+2.88*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=45,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## for the species of the family Brachioteuthidae
           ## ML= 16.31+20.18LRL ; ln M=0.55+1.41ln LRL (n= 11 for both ML and M) (Clarke 1986)
           "11758_ML_Clar1986"=list(taxon_name="Brachioteuthidae",
                                    taxon_aphia_id=11758,
                                    equation=function(...)16.31+20.18*...,
                                    input_measurement="lower rostral length",
                                    input_measurement_units="mm",
                                    return_measurement="mantle length",
                                    return_measurement_units="mm",
                                    goodness_type="N",goodness_of_fit=11,
                                    reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "11758_mass_Clar1986"=list(taxon_name="Brachioteuthidae",
                                      taxon_aphia_id=11758,
                                      equation=function(...)exp(0.55+1.41*log(...)),
                                      input_measurement="lower rostral length",
                                      input_measurement_units="mm",
                                      return_measurement="mass",
                                      return_measurement_units="g",
                                      goodness_type="N",goodness_of_fit=11,
                                      reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           ## Galiteuthis glacialis
           ##ML=6.676+83.785LRL; log M= 0.415+2.20 log LRL (n=25 for ML and M) (Lu & Williams 1994)
           "325297_ML_LuWi1994"=list(taxon_name="Galiteuthis glacialis",
                                     taxon_aphia_id=325297,
                                     equation=function(...)6.676+83.785*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=25,
                                     reference="Lu & Williams (1994) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "325297_mass_LuWi1994"=list(taxon_name="Galiteuthis glacialis",
                                       taxon_aphia_id=325297,
                                       equation=function(...)exp(0.415+2.20*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=25,
                                       reference="Lu & Williams (1994) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Taonius spp. formulas
           ## ML=-12.3+61.43LRL ; ln M=0.786+2.19 ln LRL (n=72 for ML, n=74 for M) (Rodhouse et al. 1990)
           "137853_ML_Rodh1990"=list(taxon_name="Taonius",
                                     taxon_aphia_id=137853,
                                     equation=function(...)-12.3+61.43*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=72,
                                     reference="Rodhouse et al. (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "137853_mass_Rodh1990"=list(taxon_name="Taonius",
                                     taxon_aphia_id=137853,
                                     equation=function(...)exp(0.786+2.19*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=74,
                                     reference="Rodhouse et al. (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Teuthowenia pellucida
           ## ML=22.27+29.90LRL ; ln M=0.71+1.94 ln LRL (n=41 for ML and M) (Rodhouse et al. 1990)
           "341823_ML_Rodh1990"=list(taxon_name="Teuthowenia pellucida",
                                     taxon_aphia_id=341823,
                                     equation=function(...)22.27+29.90*(...),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=41,
                                     reference="Rodhouse et al. (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341823_mass_Rodh1990"=list(taxon_name="Teuthowenia pellucida",
                                     taxon_aphia_id=341823,
                                     equation=function(...)exp(0.71+1.94*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=41,
                                     reference="Rodhouse et al. (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Mesonychoteuthis hamiltoni
           ## ML=-12.3+61.43LRL (n=72) (Rodhouse et al. 1990), although the relationship is weak and
           ## therefore evaluate carefully if it applies well to your data
           "325299_ML_Rodh1990"=list(taxon_name="Mesonychoteuthis hamiltoni",
                                     taxon_aphia_id=325299,
                                     equation=function(...)-12.3+61.43*(...),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=72,
                                     notes="Noted by Xavier & Cherel: the relationship is weak and therefore evaluate carefully if it applies well to your data",
                                     reference="Rodhouse et al. (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## family Cranchiidae:
           ## ln M=ln 3.24 + 2.80 ln LRL (Clarke 1962b).
           "11774_mass_Clar1962"=list(taxon_name="Cranchiidae",
                                      taxon_aphia_id=11774,
                                      equation=function(...)exp(log(3.24)+2.80*log(...)),
                                      input_measurement="lower rostral length",
                                      input_measurement_units="mm",
                                      return_measurement="mass",
                                      return_measurement_units="g",
                                      reference="Clarke (1962b) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Cycloteuthis akimushkini
           "341824_ML_Clar1986"=list(taxon_name="Cycloteuthis akimushkini",
                                     taxon_aphia_id=341824,
                                     equation=function(...)31*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341824_mass_Clar1986"=list(taxon_name="Cycloteuthis akimushkini",
                                     taxon_aphia_id=341824,
                                     equation=function(...)exp(1.89+1.95*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Gonatus spp.
           "138036_ML_Clar1986"=list(taxon_name="Gonatus",
                                     taxon_aphia_id=138036,
                                     equation=function(...)-43.4+42.87*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=17,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138036_mass_Clar1986"=list(taxon_name="Gonatus",
                                       taxon_aphia_id=138036,
                                       equation=function(...)exp(-0.655+3.33*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=20,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## The following equations is better for small beaks/specimens:
           ## ML=12.82+19.02LRL ; ln M=0.086+2.13ln LRL (Clarke 1986)
           "138036small_ML_Clar1986"=list(taxon_name="Gonatus",
                                          taxon_aphia_id=138036,
                                          equation=function(...)12.82+19.02*...,
                                          input_measurement="lower rostral length",
                                          input_measurement_units="mm",
                                          return_measurement="mantle length",
                                          return_measurement_units="mm",
                                          notes="Noted by Xavier & Cherel: This equation is better for small beaks/specimens",
                                          reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138036small_mass_Clar1986"=list(taxon_name="Gonatus",
                                            taxon_aphia_id=138036,
                                            equation=function(...)exp(0.086+2.13*log(...)),
                                            input_measurement="lower rostral length",
                                            input_measurement_units="mm",
                                            return_measurement="mass",
                                            return_measurement_units="g",
                                            notes="Noted by Xavier & Cherel: This equation is better for small beaks/specimens",
                                            reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Histioteuthis bonnellii corpuscula (valid name Histioteuthis bonnellii)
           ## ML=17.1+8.99LRL (n=19) (Clarke 1986)
           "140111_ML_Clar1986"=list(taxon_name="Histioteuthis bonnellii",
                                     taxon_aphia_id=140111,
                                     equation=function(...)17.1+8.99*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=19,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           ## ML=1.82+15.24LRL; ln M= 1.16+2.70lnLRL (n=21 for ML and M, using total
           ## weight of preserved specimens) (Lu & Ickeringill 2002)
           "140111_ML_LuIc2002"=list(taxon_name="Histioteuthis bonnellii",
                                     taxon_aphia_id=140111,
                                     equation=function(...)1.82+15.24*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=21,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "140111_mass_LuIc2002"=list(taxon_name="Histioteuthis bonnellii",
                                     taxon_aphia_id=140111,
                                     equation=function(...)exp(1.16+2.70*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=21,
                                     notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Histioteuthis macrohista
           ## ML=2.36+14.46LRL; ln M= 1.16+2.72lnLRL (n=8 for ML and for M, using total
           ## weight of preserved specimens) (Lu & Ickeringill 2002)
           "341870_ML_LuIc2002"=list(taxon_name="Histioteuthis macrohista",
                                     taxon_aphia_id=341870,
                                     equation=function(...)2.36+14.46*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=8,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341870_mass_LuIc2002"=list(taxon_name="Histioteuthis macrohista",
                                       taxon_aphia_id=341870,
                                       equation=function(...)exp(1.16+2.72*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=8,
                                       notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                       reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Histioteuthis miranda
           ## ML=-7.0+25.82LRL ; ln M=1.783+2.44ln LRL (n=27 for ML, n=14 for M) (Clarke
           ## 1986)
           "341871_ML_Clar1986"=list(taxon_name="Histioteuthis miranda",
                                     taxon_aphia_id=341871,
                                     equation=function(...)-7.0+25.82*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=27,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341871_mass_Clar1986"=list(taxon_name="Histioteuthis miranda",
                                       taxon_aphia_id=341871,
                                       equation=function(...)exp(1.783+2.44*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=14,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## ML=-26.51+34.21LRL; ln M= 0.86+3.04lnLRL (n=31 for ML, n=22 for M, using
           ## total weight of preserved specimens) (Lu & Ickeringill 2002)
           "341871_ML_LuIc2002"=list(taxon_name="Histioteuthis miranda",
                                     taxon_aphia_id=341871,
                                     equation=function(...)-26.51+34.21*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=31,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341871_mass_LuIc2002"=list(taxon_name="Histioteuthis miranda",
                                                taxon_aphia_id=341871,
                                                equation=function(...)exp(0.86+3.04*log(...)),
                                                input_measurement="lower rostral length",
                                                input_measurement_units="mm",
                                                return_measurement="mass",
                                                return_measurement_units="g",
                                                goodness_type="N",goodness_of_fit=22,
                                                notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                                reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Histioteuthis atlantica
           ## ML=-10.42+25.66LRL; ln M= 1.49+2.45lnLRL (n=21 for ML, n=19 for M, using
           ## total weight of preserved specimens) (Lu & Ickeringill 2002)
           "341864_ML_LuIc2002"=list(taxon_name="Histioteuthis atlantica",
                                     taxon_aphia_id=341864,
                                     equation=function(...)-10.42+25.66*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=21,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341864_mass_LuIc2002"=list(taxon_name="Histioteuthis atlantica",
                                     taxon_aphia_id=341864,
                                     equation=function(...)exp(1.49+2.45*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=19,
                                     notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Histioteuthis eltaninae
           ## ML=-3.65+24.48LRL; ln M= 0.33+3.11lnLRL (n=6 for ML, n=5 for M, using total
           ## weight of preserved specimens) (Lu & Ickeringill 2002)
           "341867_ML_LuIc2002"=list(taxon_name="Histioteuthis eltaninae",
                                     taxon_aphia_id=341867,
                                     equation=function(...)-3.65+24.48*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=6,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341867_mass_LuIc2002"=list(taxon_name="Histioteuthis eltaninae",
                                     taxon_aphia_id=341867,
                                     equation=function(...)exp(0.33+3.11*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     goodness_type="N",goodness_of_fit=5,
                                     notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Lepidoteuthis grimaldii
           ## ML=36.2LRL ; ln M=-0.17+3.0ln LRL (British Antarctic Survey, unpublished data)
           "140193_ML_BASunpub"=list(taxon_name="Lepidoteuthis grimaldii",
                                     taxon_aphia_id=140193,
                                     equation=function(...)36.2*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "140193_mass_BASunpub"=list(taxon_name="Lepidoteuthis grimaldii",
                                       taxon_aphia_id=140193,
                                       equation=function(...)exp(-0.17+3.0*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## ML=-10.60+50.57LRL (n=2, using total weight of preserved specimens) (Lu & Ickeringill
           ## 2002) but this relationship is obviously not strong
           "140193_ML_LuIc2002"=list(taxon_name="Lepidoteuthis grimaldii",
                                     taxon_aphia_id=140193,
                                     equation=function(...)-10.60+50.57*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=2,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Loligo gahi (accepted name Doryteuthis (Amerigo) gahi)
           ## ln ML= 4.23+1.01lnLRL ; ln M=2.25+2.39lnLRL (n=446) (British Antarctic Survey, unpublished data)
           "410351_ML_BASunpub"=list(taxon_name="Doryteuthis (Amerigo) gahi",
                                     taxon_aphia_id=410351,
                                     equation=function(...)exp(4.23+1.01*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=446,
                                     reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "410351_mass_BASunpub"=list(taxon_name="Doryteuthis (Amerigo) gahi",
                                       taxon_aphia_id=410351,
                                       equation=function(...)exp(2.25+2.39*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=446,
                                       reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Lycoteuthis lorigera
           ## ML=-13.04+34.56LRL; ln M= 0.32+3.00lnLRL (n=45 for ML and M, using total weight
           ## of preserved specimens) (Lu & Ickeringill 2002)
           "342361_ML_LuIc2002"=list(taxon_name="Lycoteuthis lorigera",
                                     taxon_aphia_id=342361,
                                     equation=function(...)-13.04+34.56*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=45,
                                     reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342361_mass_LuIc2002"=list(taxon_name="Lycoteuthis lorigera",
                                       taxon_aphia_id=342361,
                                       equation=function(...)exp(0.32+3.00*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=45,
                                       notes="Noted by Xavier & Cherel: used total weight of preserved specimens",
                                       reference="Lu & Ickeringill (2002) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Mastigoteuthis psychrophila
           ## ML=94.424+6.203LRL ; log M=0.701+1.779logLRL (n=19 for ML and M) (British
           ## Antarctic Survey, unpublished data)
           "341904_ML_BASunpub"=list(taxon_name="Mastigoteuthis psychrophila",
                                     taxon_aphia_id=341904,
                                     equation=function(...)94.424+6.203*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=19,
                                     reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "341904_mass_BASunpub"=list(taxon_name="Mastigoteuthis psychrophila",
                                       taxon_aphia_id=341904,
                                       equation=function(...)exp(0.701+1.779*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=19,
                                       reference="BAS (unpublished data) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Alluroteuthis antarcticus
           ## ML=-4.301+34.99LRL ; ln M=1.229+2.944ln LRL (n=22) (Piatkowski et al. 2001).
           "325302_ML_Piat2001"=list(taxon_name="Alluroteuthis antarcticus",
                                     taxon_aphia_id=325302,
                                     equation=function(...)-4.301+34.99*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=22,
                                     reference="Piatkowski et al. (2001) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "325302_mass_Piat2001"=list(taxon_name="Alluroteuthis antarcticus",
                                       taxon_aphia_id=325302,
                                       equation=function(...)exp(1.229+2.944*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=22,
                                       reference="Piatkowski et al. (2001) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Taningia danae
           ## ML=-556.9+75.22LRL; ln M=-0.874+3.42ln LRL (n=15 for ML and M) (Clarke 1986)
           "140609_ML_Clark1986"=list(taxon_name="Taningia danae",
                                      taxon_aphia_id=140609,
                                      equation=function(...)-556.9+75.22*...,
                                      input_measurement="lower rostral length",
                                      input_measurement_units="mm",
                                      return_measurement="mantle length",
                                      return_measurement_units="mm",
                                      goodness_type="N",goodness_of_fit=15,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "140609_mass_Clark1986"=list(taxon_name="Taningia danae",
                                        taxon_aphia_id=140609,
                                        equation=function(...)exp(-0.874+3.42*log(...)),
                                        input_measurement="lower rostral length",
                                        input_measurement_units="mm",
                                        return_measurement="mass",
                                        return_measurement_units="g",
                                        goodness_type="N",goodness_of_fit=15,
                                        reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Octopoteuthis sp.
           ## ML=-0.4+17.33LRL; ln M=0.166+2.31ln LRL (n=30 for ML, n=22 M) (Clarke 1986)
           "138271_ML_Clark1986"=list(taxon_name="Octopoteuthis",
                                      taxon_aphia_id=138271,
                                      equation=function(...)-0.4+17.33*...,
                                      input_measurement="lower rostral length",
                                      input_measurement_units="mm",
                                      return_measurement="mantle length",
                                      return_measurement_units="mm",
                                      goodness_type="N",goodness_of_fit=30,
                                      reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138271_mass_Clark1986"=list(taxon_name="Octopoteuthis",
                                        taxon_aphia_id=138271,
                                        equation=function(...)exp(0.166+2.31*log(...)),
                                        input_measurement="lower rostral length",
                                        input_measurement_units="mm",
                                        return_measurement="mass",
                                        return_measurement_units="g",
                                        goodness_type="N",goodness_of_fit=22,
                                        reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Martialia hyadesi
           ## ML= 102.0+29.47LRL ; ln M=2.405+2.012 ln LRL (n=67 for ML and M) (Rodhouse
           ## & Yeatman 1990)
           "325305_ML_RoYe1990"=list(taxon_name="Martialia hyadesi",
                                     taxon_aphia_id=325305,
                                     equation=function(...)102.0+29.47*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=67,
                                     reference="Rodhouse & Yeatman (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "325305_mass_RoYe1990"=list(taxon_name="Martialia hyadesi",
                                       taxon_aphia_id=325305,
                                       equation=function(...)exp(2.405+2.012*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=67,
                                       reference="Rodhouse & Yeatman (1990) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Illex argentinus
           ## ML=-12.228+55.187LRL ; M=2.2750 LRL3.1210 (n=131for ML and M) (Santos & Haimovici 2000)
           "342064_ML_SaHa2000"=list(taxon_name="Illex argentinus",
                                     taxon_aphia_id=342064,
                                     equation=function(...)-12.228+55.187*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=131,
                                     reference="Santos & Haimovici (2000) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342064_mass_SaHa2000"=list(taxon_name="Illex argentinus",
                                       taxon_aphia_id=342064,
                                       equation=function(...)2.2750*(...^3.1210),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=131,
                                       reference="Santos & Haimovici (2000) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           ## Todarodes sp.
           ## ML=-11.3+41.36LRL ; ln M=0.783+2.83 ln LRL (Clarke 1986)
           "138281_ML_Clar1986"=list(taxon_name="Todarodes",
                                     taxon_aphia_id=138281,
                                     equation=function(...)-11.3+41.36*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138281_mass_Clar1986"=list(taxon_name="Todarodes",
                                       taxon_aphia_id=138281,
                                       equation=function(...)exp(0.783+2.83*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Kondakovia longimana
           ## ML=-22.348+37.318LRL ; M=0.713LRL3.152 (n=13 for ML; n=22 for M) (Brown &
           ## Klages 1987)
           "325308_ML_BrKl1987"=list(taxon_name="Kondakovia longimana",
                                     taxon_aphia_id=325308,
                                     equation=function(...)-22.348+37.318*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     goodness_type="N",goodness_of_fit=13,
                                     reference="Brown & Klages (1987) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "325308_mass_BrKl1987"=list(taxon_name="Kondakovia longimana",
                                       taxon_aphia_id=325308,
                                       equation=function(...)0.713*(...^3.152),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       goodness_type="N",goodness_of_fit=22,
                                       reference="Brown & Klages (1987) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Moroteuthis ingens (valid name Onykia ingens)
           ## (Jackson 1995):
           ## Males: ML= 98.59+24.40LRL (n=82); females: ML=-27.84+44.63LRL (n=68)
           ## Males: logM= 1.22+1.80logLRL (n=82); females: logM= 0.15+3.25logLRL (n=68)
           "410381M_ML_Jack1995"=list(taxon_name="Onykia ingens",
                                      taxon_aphia_id=410381,
                                      equation=function(...)98.59+24.40*...,
                                      input_measurement="lower rostral length",
                                      input_measurement_units="mm",
                                      return_measurement="mantle length",
                                      return_measurement_units="mm",
                                      goodness_type="N",goodness_of_fit=82,
                                      reference="Jackson (1995) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),


           stop("unrecognized equation ID: ",id))
}


## otolith equations from Williams & McEldowney 1990
alleq_wm <- function(id) {
    switch(id,
           ## Bathylagus antarcticus
           "234631_SL~OL_WiMc1990"=list(taxon_name="Bathylagus antarcticus",
                                       taxon_aphia_id=234631,
                                       equation=function(...)56.16975*(...)-39.7831,
                                       goodness_of_fit=0.875^2,
                                       goodness_type="R^2",
                                       input_measurement="otolith length",
                                       input_measurement_units="mm",
                                       return_measurement="standard length",
                                       return_measurement_units="mm",
                                       goodness_type="N",goodness_of_fit=17,
                                       reference="Williams R & McEldowney A (1990) A guide to the fish otoliths from waters off the Australian Antarctic Territory, Heard and Macquarie Islands. ANARE Research Notes 75. Antarctic Division, Australian Government"),
           "234631_SL~OW_WiMc1990"=list(taxon_name="Bathylagus antarcticus",
                                       taxon_aphia_id=234631,
                                       equation=function(...)115.7744*(...)-47.0855,
                                       goodness_of_fit=0.95^2,
                                       goodness_type="R^2",
                                       input_measurement="otolith width",
                                       input_measurement_units="mm",
                                       return_measurement="standard length",
                                       return_measurement_units="mm",
                                       goodness_type="N",goodness_of_fit=17,
                                       reference="Williams R & McEldowney A (1990) A guide to the fish otoliths from waters off the Australian Antarctic Territory, Heard and Macquarie Islands. ANARE Research Notes 75. Antarctic Division, Australian Government"),

           stop("unrecognized equation ID: ",id))
}


## wrapper function around alleq. Can override the taxon, if e.g. applying an equation developed for one species to another species
## can override reference
alleq_tbl <- function(id,taxon_name,taxon_aphia_id,notes,reference) {
    thiseq <- NULL
    try(thiseq <- alleq_xc(id),silent=TRUE)
    if (is.null(thiseq)) try(thiseq <- alleq_wm(id),silent=TRUE)
    if (is.null(thiseq)) stop("equation id not recognized: ",id)

    ## use the equation defaults for some thing, if not already specified
    if (missing(taxon_name)) taxon_name <- thiseq$taxon_name
    if (missing(taxon_aphia_id)) taxon_aphia_id <- thiseq$taxon_aphia_id
    if (missing(reference)) reference <- thiseq$reference
    if (missing(notes)) {
        notes <- if (is.null(thiseq$notes)) "" else thiseq$notes
    }
    if (is.null(thiseq$goodness_of_fit)) thiseq$goodness_of_fit <- NA
    if (is.null(thiseq$goodness_type)) thiseq$goodness_type <- NA_character_

    tribble(~equation_id,~taxon_name,~taxon_aphia_id,~equation,~input_measurement,~input_measurement_units,~return_measurement,~return_measurement_units,~goodness_of_fit,~goodness_type,~notes,~reference,
            id,taxon_name,taxon_aphia_id,thiseq$equation,thiseq$input_measurement,thiseq$input_measurement_units,thiseq$return_measurement,thiseq$return_measurement_units,thiseq$goodness_of_fit,thiseq$goodness_type,notes,reference)
}

build_allometry_df <- function() {
    ## equations from Xavier and Cherel
    ## Ancistrocheirus lesueuri
    x <- bind_rows(alleq_tbl("138747_ML_Clar1986"),alleq_tbl("138747_mass_Clar1986"))

    ## Architeuthis dux
    x <- bind_rows(x,alleq_tbl("342218_ML_Clar1986"),alleq_tbl("342218_mass_Clar1986"),alleq_tbl("342218_ML_Roel2000",notes="Noted by Xavier & Cherel: this equation for mantle_length from LRL might be better than the Clarke (1986) one"))

    ## Bathyteuthis abyssicola
    x <- bind_rows(x,alleq_tbl("138848_ML_Clar1986"),alleq_tbl("138848_mass_Clar1986"))

    ## Batoteuthis skolops (no specific equations)
    x <- bind_rows(x,alleq_tbl("137777_ML_Clar1986",taxon_name="Batoteuthis skolops",taxon_aphia_id=325293,
                               notes="Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops"),
                   alleq_tbl("137777_mass_Clar1986",taxon_name="Batoteuthis skolops",taxon_aphia_id=325293,
                              notes="Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops"),
                   alleq_tbl("138168_ML_Clar1986",taxon_name="Batoteuthis skolops",taxon_aphia_id=325293,
                             notes="Based on Mastigoteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops"),
                   alleq_tbl("138168_mass_Clar1986",taxon_name="Batoteuthis skolops",taxon_aphia_id=325293,
                             notes="Based on Mastigoteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops"))

    ## family Brachioteuthidae
    x <- bind_rows(x,alleq_tbl("11758_ML_Clar1986"),alleq_tbl("11758_mass_Clar1986"))
    ## note that this will require some additional coding in the user function, so that e.g. an input taxon_name of "Brachioteuthis picta" will find its way to this equation even though it does not directly match the taxon_name or taxon_aphia_id specified here


    ## Chiroteuthis veranyi (no specific equations)
    x <- bind_rows(x,alleq_tbl("137777_ML_Clar1986",taxon_name="Chiroteuthis veranii",taxon_aphia_id=139125,
                               notes="Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii"),
                   alleq_tbl("137777_mass_Clar1986",taxon_name="Chiroteuthis veranii",taxon_aphia_id=139125,
                             notes="Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii"))

    ## Galiteuthis glacialis
    x <- bind_rows(x,alleq_tbl("325297_ML_LuWi1994"),alleq_tbl("325297_mass_LuWi1994"))

    ## Galiteuthis stC sp. (Imber) (no specific equations)
    ## Galiteuthis sp. 3 (Imber) (no specific equations)
    ## Taonius sp. B (Voss) (no specific equations)
    ## Taonius sp. (Clarke) (no specific equations)

    ## Taonius sp
    x <- bind_rows(x,alleq_tbl("137853_ML_Rodh1990"),alleq_tbl("137853_mass_Rodh1990"))

    ## Teuthowenia pellucida
    x <- bind_rows(x,alleq_tbl("341823_ML_Rodh1990"),alleq_tbl("341823_mass_Rodh1990"))

    ## Mesonychoteuthis hamiltoni
    x <- bind_rows(x,alleq_tbl("325299_ML_Rodh1990"))

    ## Cranchiidae
    x <- bind_rows(x,alleq_tbl("11774_mass_Clar1962"))

    ## Cycloteuthis akimushkini
    x <- bind_rows(x,alleq_tbl("341824_ML_Clar1986"),alleq_tbl("341824_mass_Clar1986"))

    ## Gonatus
    x <- bind_rows(x,alleq_tbl("138036_ML_Clar1986"),alleq_tbl("138036_mass_Clar1986"))
    ## Gonatus (small specimens)
    x <- bind_rows(x,alleq_tbl("138036small_ML_Clar1986"),alleq_tbl("138036small_mass_Clar1986"))

    ## Gonatus antarcticus (no specific equations)
    x <- bind_rows(x,alleq_tbl("138036_ML_Clar1986",taxon_name="Gonatus antarcticus",taxon_aphia_id=325300,
                               notes="Based on Gonatus spp. formula from Clarke (1986). There are no specific equations for Gonatus antarcticus"),
                   alleq_tbl("138036_mass_Clar1986",taxon_name="Gonatus antarcticus",taxon_aphia_id=325300,
                             notes="Based on Gonatus spp. formula from Clarke (1986). There are no specific equations for Gonatus antarcticus"))
    ## (small specimens)
    x <- bind_rows(x,alleq_tbl("138036small_ML_Clar1986",taxon_name="Gonatus antarcticus",taxon_aphia_id=325300,
                               notes="Based on Gonatus spp. formula from Clarke (1986). There are no specific equations for Gonatus antarcticus"),
                   alleq_tbl("138036small_mass_Clar1986",taxon_name="Gonatus antarcticus",taxon_aphia_id=325300,
                             notes="Based on Gonatus spp. formula from Clarke (1986). There are no specific equations for Gonatus antarcticus"))

    ## Histioteuthis A, which has a deep notch in back of hood and a well-developed ridge
    ##  running to free corner of lateral wall:
    ## Histioteuthis arcturi (no specific equations)

    ## Histioteuthis bonnellii corpuscula (valid name Histioteuthis bonnellii)
    x <- bind_rows(x,alleq_tbl("140111_ML_Clar1986"),alleq_tbl("140111_ML_LuIc2002"),
                   alleq_tbl("140111_mass_LuIc2002"))

    ## Histioteuthis macrohista
    x <- bind_rows(x,alleq_tbl("341870_ML_LuIc2002"),alleq_tbl("341870_mass_LuIc2002"))

    ## Histioteuthis miranda
    x <- bind_rows(x,alleq_tbl("341871_ML_Clar1986"),alleq_tbl("341871_mass_Clar1986"))
    x <- bind_rows(x,alleq_tbl("341871_ML_LuIc2002"),alleq_tbl("341871_mass_LuIc2002"))

    ## Histioteuthis B has a shallow notch in back of hood and a weakly-developed ridge under
    ## the hood (evident in Histioteuthis atlantica juveniles) that becomes a slight fold running to free corner
    ## of lateral wall:

    ## Histioteuthis atlantica
    x <- bind_rows(x,alleq_tbl("341864_ML_LuIc2002"),alleq_tbl("341864_mass_LuIc2002"))

    ## Histioteuthis eltaninae
    x <- bind_rows(x,alleq_tbl("341867_ML_LuIc2002"),alleq_tbl("341867_mass_LuIc2002"))

    ## Lepidoteuthis grimaldii
    x <- bind_rows(x,alleq_tbl("140193_ML_BASunpub"),alleq_tbl("140193_mass_BASunpub"),alleq_tbl("140193_ML_LuIc2002"))

    ## Loligo gahi (accepted name Doryteuthis (Amerigo) gahi)
    x <- bind_rows(x,alleq_tbl("410351_ML_BASunpub"),alleq_tbl("410351_mass_BASunpub"))
    ## also with common name alternatives
    x <- bind_rows(x,alleq_tbl("410351_ML_BASunpub",taxon_name="Loligo gahi"),
                   alleq_tbl("410351_mass_BASunpub",taxon_name="Loligo gahi"))
    x <- bind_rows(x,alleq_tbl("410351_ML_BASunpub",taxon_name="Doryteuthis gahi"),
                   alleq_tbl("410351_mass_BASunpub",taxon_name="Doryteuthis gahi"))


    ## Lycoteuthis lorigera
    x <- bind_rows(x,alleq_tbl("342361_ML_LuIc2002"),alleq_tbl("342361_mass_LuIc2002"))

    ## Mastigoteuthis psychrophila
    x <- bind_rows(x,alleq_tbl("341904_ML_BASunpub"),alleq_tbl("341904_mass_BASunpub"))

    ## ?Mastigoteuthis A (Clarke) (no specific equations)

    ## Alluroteuthis antarcticus
    x <- bind_rows(x,alleq_tbl("325302_ML_Piat2001"),alleq_tbl("325302_mass_Piat2001"))

    ## Nototeuthis dimegacotyle (no specific equations)

    ## Taningia danae
    x <- bind_rows(x,alleq_tbl("140609_ML_Clark1986"),alleq_tbl("140609_mass_Clark1986"))

    ## Octopoteuthis sp.
    x <- bind_rows(x,alleq_tbl("138271_ML_Clark1986"),alleq_tbl("138271_mass_Clark1986"))

    ## Martialia hyadesi
    x <- bind_rows(x,alleq_tbl("325305_ML_RoYe1990"),alleq_tbl("325305_mass_RoYe1990"))

    ## Illex argentinus
    x <- bind_rows(x,alleq_tbl("342064_ML_SaHa2000"),alleq_tbl("342064_mass_SaHa2000"))

    ## Todarodes sp. (no specific equations)
    x <- bind_rows(x,alleq_tbl("138281_ML_Clar1986"),alleq_tbl("138281_mass_Clar1986"))

    ## Kondakovia longimana
    x <- bind_rows(x,alleq_tbl("325308_ML_BrKl1987"),alleq_tbl("325308_mass_BrKl1987"))

    ## Moroteuthis ingens
    ## It is provided the mean value between estimates obtained using equations for males and
    ## females (Jackson 1995):
    ## Males: ML= 98.59+24.40LRL (n=82); females: ML=-27.84+44.63LRL (n=68)
    ## Males: logM= 1.22+1.80logLRL (n=82); females: logM= 0.15+3.25logLRL (n=68)

    ## Moroteuthis knipovitchi
    ## ML=-105.707+62.369LRL; ln M=-0.881+3.798lnLRL (n=7 for ML, n=5 for M) (Cherel,
    ## unpublished data)

    ## Moroteuthis robsoni
    ## ML=-652.91+151.03LRL; ln M= -9.15+8.07lnLRL (n=8 for ML, n=6 for M, using total
    ## weight of preserved specimens) (Lu & Ickeringill 2002)

    ## Moroteuthis sp . B (Imber) (no specific equations)

    ## Onychoteuthis banksii
    ## ML=2.31+32.75LRL; ln M= -0.04+2.80lnLRL (n=10 for ML and M, using total weight
    ## of preserved specimens) (Lu & Ickeringill 2002)

    ## Pholidoteuthis massyae
    ## ML=11.3+41.09LRL ; ln M=0.976+2.83ln LRL (n=12 for ML, n=15 for M) (Clarke 1986)

    ## Psychroteuthis glacialis
    ## ML= 50.6895LRL-8.6008LRL2+1.0823LRL3-8.7019 (n=211) ; ln M = 0.3422+2.1380
    ## lnLRL+0.2214lnLRL3 (Gröger et al. 2000)

    ## FAMILY SEPIOLIDAE
    ## cf. Stoloteuthis leucoptera
    ## [no eq]


    ## Oegopsida sp. A (Cherel) (no allometric equations available)

    ## Haliphron atlanticus
    ## Ln M=2.5+1.45ln LRL (British Antarctic Survey, unpublished data)

    ## Cirrata sp. A (Cherel) (no allometric equations available)

    ## Pareledone turqueti
    ## ML=17.70487+ 13.32812LHL; LnM =0.689269+2.542938LnLHL (n=7 for ML, n=23 for
    ## M), where LHL= lower hood length (in mm) (Collins, unpublished data)

    ## Adelieledone polymorpha
    ## ML= -7,426229508+25,16393443LHL; Ln M =1,077552+3,200449LnLHL
    ##  (n=3 for ML, n= 39 for M) (Collins, unpublished data)

    ## Benthoctopus thielei
    ## ML = 7.398+12.569LHL; lnM= 0.471+2.706lnLHL (n=48 for ML and M) (Cherel,
    ## unpublished data)

    ## Graneledone gonzalezi
    ## ML = 5.047+13.004LHL; lnM= 0.288+2.967lnLHL (n=54 for ML and M) (Cherel,
    ## unpublished data)

    ## Opisthoteuthis sp.
    ## ML=-26.0047+12.4858CL; logM=0.5893+0.2413CL (n= 13 for ML, n=9 for M) (Smale
    ## et al. 1993) where CL = Crest length (in mm)

    ## Stauroteuthis gilchristi (no allometric equations available)

    ## Williams & McEldowney 1990 otoliths
    ## Bathylagus antarcticus
    x <- bind_rows(x,alleq_tbl("234631_SL~OL_WiMc1990"),alleq_tbl("234631_SL~OW_WiMc1990"))

    x
}

allometry_data <- build_allometry_df()
## todo: check each row that taxon_name and taxon_aphia_id match (or are expected mismatches, at least)

#use_data(allometry_data,internal=FALSE,overwrite=TRUE)
