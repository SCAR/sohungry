library(dplyr)

## define each unique equation, along with its nominal taxon and reference
alleq <- function(id) {
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
                                     N=23,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138747_mass_Clar1986"=list(taxon_name="Ancistrocheirus lesueuri",
                                       taxon_aphia_id=138747,
                                       equation=function(...)exp(-0.194+3.56*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       N=21,
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
                                     N=11,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342218_mass_Clar1986"=list(taxon_name="Architeuthis dux",
                                       taxon_aphia_id=342218,
                                       equation=function(...)exp(-1.773+4.57*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       N=9,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "342218_ML_Roel2000"=list(taxon_name="Architeuthis dux",
                                     taxon_aphia_id=342218,
                                     equation=function(...)10^((.../11.2)+1.723214286),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     N=43,
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
                                     N=17,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138848_mass_Clar1986"=list(taxon_name="Bathyteuthis abyssicola",
                                       taxon_aphia_id=138848,
                                       equation=function(...)exp(2.855+3.38*log(...)),
                                       input_measurement="lower rostral length",
                                       input_measurement_units="mm",
                                       return_measurement="mass",
                                       return_measurement_units="g",
                                       N=17,
                                       reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           ## Batoteuthis skolops (no specific equations)
           ## May use formulas for close families
           ## ML=11.4+24.46LRL; ln M=-0.241+2.7ln LRL (n=23 for ML, n=14 for M) (Clarke 1986),
           ## based on Chiroteuthis spp. formulas
           ## ML=-1.8+29.08LRL ; ln M=0.184+2.88ln LRL (n=47 for ML, n=45 for M) (Clarke 1986),
           ## based on Mastigoteuthis spp. formulas
           "137777_ML_Clar1986"=list(taxon_name="Chiroteuthis",
                                     taxon_aphia_id=137777,
                                     equation=function(...)11.4+24.46*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     N=23,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "137777_mass_Clar1986"=list(taxon_name="Chiroteuthis",
                                     taxon_aphia_id=137777,
                                     equation=function(...)exp(-0.241+2.7*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     N=14,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138168_ML_Clar1986"=list(taxon_name="Mastigoteuthis",
                                     taxon_aphia_id=138168,
                                     equation=function(...)-1.8+29.08*...,
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mantle length",
                                     return_measurement_units="mm",
                                     N=47,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),
           "138168_mass_Clar1986"=list(taxon_name="Mastigoteuthis",
                                     taxon_aphia_id=138168,
                                     equation=function(...)exp(0.184+2.88*log(...)),
                                     input_measurement="lower rostral length",
                                     input_measurement_units="mm",
                                     return_measurement="mass",
                                     return_measurement_units="g",
                                     N=45,
                                     reference="Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."),

           stop("unrecognized equation ID: ",id))
}

## wrapper function around alleq. Can override the taxon, if e.g. applying an equation developed for one species to another species
## can override reference
alleq_tbl <- function(id,taxon_name,taxon_aphia_id,notes="",reference) {
    thiseq <- alleq(id)
    ## use the equation defaults for some thing, if not already specified
    if (missing(taxon_name)) taxon_name <- thiseq$taxon_name
    if (missing(taxon_aphia_id)) taxon_aphia_id <- thiseq$taxon_aphia_id
    if (missing(reference)) reference <- thiseq$reference
    tribble(~equation_id,~taxon_name,~taxon_aphia_id,~equation,~input_measurement,~input_measurement_units,~return_measurement,~return_measurement_units,~N,~notes,~reference,
            id,taxon_name,taxon_aphia_id,thiseq$equation,thiseq$input_measurement,thiseq$input_measurement_units,thiseq$return_measurement,thiseq$return_measurement_units,thiseq$N,notes,reference)
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

    stop("up to here")
    ## ML= 16.31+20.18LRL ; ln M=0.55+1.41ln LRL (n= 11 for both ML and M) (Clarke 1986)
    ## for the species of the family Brachioteuthidae
    x <- bind_rows(x,tribble(~equation_id,~taxon_name,~taxon_aphia_id,~equation,~input_measurement,~input_measurement_units,~return_measurement,~return_measurement_units,~N,~notes,~reference,
                             "11758_ML_Clar1986","Brachioteuthidae",11758,function(...)16.31+20.18*...,"lower rostral length","mm","mantle length","mm",11,"Applies to species of the family Brachioteuthidae","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "11758_mass_Clar1986","Brachioteuthidae",11758,function(...)exp(0.55+1.41*log(...)),"lower rostral length","mm","mass","g",11,"Applies to species of the family Brachioteuthidae","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))
    ## note that this will require some additional coding in the user function, so that e.g. an input taxon_name of "Brachioteuthis picta" will find its way to this equation even though it does not directly match the taxon_name or taxon_aphia_id specified here


    ## Chiroteuthis veranyi (no specific equations)
    ## ML=11.4+24.46LRL ; ln M=-0.241+2.7 ln LRL (n=23 for ML, n=14 for M) (Clarke 1986), based on Chiroteuthis spp. formulas
    x <- bind_rows(x,tribble(~equation_id,~taxon_name,~taxon_aphia_id,~equation,~input_measurement,~input_measurement_units,~return_measurement,~return_measurement_units,~N,~notes,~reference,
                             "137777_ML_Clar1986","Chiroteuthis veranii",139125,function(...)11.4+24.46*...,"lower rostral length","mm","mantle length","mm",23,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "137777_mass_Clar1986","Chiroteuthis veranii",139125,function(...)exp(-0.241+2.7*log(...)),"lower rostral length","mm","mass","g",14,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    ## Galiteuthis glacialis
    ##ML=6.676+83.785LRL; log M= 0.415+2.20 log LRL (n=25 for ML and M) (Lu & Williams 1994)
    ML=6.676+83.785LRL
    log M= 0.415+2.20 log LRL

    ## Galiteuthis stC sp. (Imber) (no specific equations)
    ## Galiteuthis sp. 3 (Imber) (no specific equations)
    ## Taonius sp. B (Voss) (no specific equations)
    ## ML=-12.3+61.43LRL ; ln M=0.786+2.19 ln LRL (n=72 for ML, n=74 for M) (Rodhouse et al. 1990) based on Taonius spp. formulas
    ML=-12.3+61.43LRL
    M=0.786+2.19 ln LRL (n=72 for ML, n=74 for M) (Rodhouse et al. 1990) based on Taonius spp. formulas

    ## Taonius sp. (Clarke) (no specific equations)
    ## Teuthowenia pellucida
    ## ML=22.27+29.90LRL ; ln M=0.71+1.94 ln LRL (n=41 for ML and M) (Rodhouse et al. 1990)
    ML=22.27+29.90LRL
    ln M=0.71+1.94 ln LRL (n=41 for ML and M) (Rodhouse et al. 1990)

    ## Mesonychoteuthis hamiltoni
    ## ML=-12.3+61.43LRL (n=72) (Rodhouse et al. 1990), although the relationship is weak and
    ## therefore evaluate carefully if it applies well to your data
    ML=-12.3+61.43LRL

    ## Although some species might have equations for M, in certain cases it might be better
    ## to apply the following allometric equation for all squids in this family Cranchiidae:
    ## ln M=ln 3.24 + 2.80 ln LRL (Clarke 1962b).
    ln M=ln 3.24 + 2.80 ln LRL (Clarke 1962b).


    ## Cycloteuthis akimushkini
    ## ML= 31LRL ; ln M = 1.89+1.95 ln LRL (Clarke 1986)
    ML= 31LRL
    ln M = 1.89+1.95 ln LRL (Clarke 1986)

    ## Gonatus antarcticus (no specific equations)
    ## ML=-43.4+42.87LRL ; ln M=-0.655+3.33ln LRL (n=17 for ML, n=20 for M) (Clarke 1986) based on Gonatus spp. formulas

    ## The following equations is better for small beaks/specimens:
    ## ML=12.82+19.02LRL ; ln M=0.086+2.13ln LRL (Clarke 1986)
    ML=12.82+19.02LRL
    ln M=0.086+2.13ln LRL (Clarke 1986)


## Histioteuthis A, which has a deep notch in back of hood and a well-developed ridge
##  running to free corner of lateral wall:
## H. arcturi (no specific equations)
## H. bonnellii corpuscula
## ML=17.1+8.99LRL (n=19) (Clarke 1986)
## ML=1.82+15.24LRL; ln M= 1.16+2.70lnLRL (n=21 for ML and M, using total
## weight of preserved specimens) (Lu & Ickeringill 2002)
## H. macrohista
## ML=2.36+14.46LRL; ln M= 1.16+2.72lnLRL (n=8 for ML and for M, using total
## weight of preserved specimens) (Lu & Ickeringill 2002)
## H. miranda
## ML=-7.0+25.82LRL ; ln M=1.783+2.44ln LRL (n=27 for ML, n=14 for M) (Clarke
## 1986)
## ML=-26.51+34.21LRL; ln M= 0.86+3.04lnLRL (n=31 for ML, n=22 for M, using
## total weight of preserved specimens) (Lu & Ickeringill 2002)
##
## Histioteuthis B has a shallow notch in back of hood and a weakly-developed ridge under
## the hood (evident in H. atlantica juveniles) that becomes a slight fold running to free corner
## of lateral wall:
## H. atlantica
## ML=-10.42+25.66LRL; ln M= 1.49+2.45lnLRL (n=21 for ML, n=19 for M, using
## total weight of preserved specimens) (Lu & Ickeringill 2002)
## H. eltaninae
## ML=-3.65+24.48LRL; ln M= 0.33+3.11lnLRL (n=6 for ML, n=5 for M, using total
## weight of preserved specimens) (Lu & Ickeringill 2002)
##
## Lepidoteuthis grimaldii
## ML=36.2LRL ; ln M=-0.17+3.0ln LRL (British Antarctic Survey, unpublished data)
## ML=-10.60+50.57LRL (n=2, using total weight of preserved specimens) (Lu & Ickeringill
## 2002) but this relationship is obviously not strong
##
## Loligo gahi
## ln ML= 4.23+1.01lnLRL ; ln M=2.25+2.39lnLRL (n=446) (British Antarctic Survey,
## unpublished data)
##
## Lycoteuthis lorigera
## ML=-13.04+34.56LRL; ln M= 0.32+3.00lnLRL (n=45 for ML and M, using total weight
## of preserved specimens) (Lu & Ickeringill 2002)
##
## Mastigoteuthis psychrophila
## ML=94.424+6.203LRL ; log M=0.701+1.779logLRL (n=19 for ML and M) (British
## Antarctic Survey, unpublished data)
##
## ?Mastigoteuthis A (Clarke) (no specific equations)
##
## Alluroteuthis antarcticus
## ML=-4.301+34.99LRL ; ln M=1.229+2.944ln LRL (n=22) (Piatkowski et al. 2001).
##
## Nototeuthis dimegacotyle (no specific equations)
##
## Taningia danae
## ML=-556.9+75.22LRL; ln M=-0.874+3.42ln LRL (n=15 for ML and M) (Clarke 1986)
## Octopoteuthis sp.
## ML=-0.4+17.33LRL; ln M=0.166+2.31ln LRL (n=30 for ML, n=22 M) (Clarke 1986)
##
##
## Martialia hyadesi
## ML= 102.0+29.47LRL ; ln M=2.405+2.012 ln LRL (n=67 for ML and M) (Rodhouse
## & Yeatman 1990)
## Illex argentinus
## ML=-12.228+55.187LRL ; M=2.2750 LRL3.1210 (n=131for ML and M) (Santos &
## Haimovici 2000)
## Todarodes sp. (no specific equations)
## ML=-11.3+41.36LRL ; ln M=0.783+2.83 ln LRL (Clarke 1986), based on Todarodes spp.
## formulas
##
## Kondakovia longimana
## ML=-22.348+37.318LRL ; M=0.713LRL3.152 (n=13 for ML; n=22 for M) (Brown &
## Klages 1987)
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
##
## Onychoteuthis banksii
## ML=2.31+32.75LRL; ln M= -0.04+2.80lnLRL (n=10 for ML and M, using total weight
## of preserved specimens) (Lu & Ickeringill 2002)
##
## Pholidoteuthis massyae
## ML=11.3+41.09LRL ; ln M=0.976+2.83ln LRL (n=12 for ML, n=15 for M) (Clarke 1986)
##
## Psychroteuthis glacialis
## ML= 50.6895LRL-8.6008LRL2+1.0823LRL3-8.7019 (n=211) ; ln M = 0.3422+2.1380
## lnLRL+0.2214lnLRL3 (Gröger et al. 2000)
##
## FAMILY SEPIOLIDAE
## cf. Stoloteuthis leucoptera
## [no eq]
##
##
## Oegopsida sp. A (Cherel) (no allometric equations available)
##
##
## Haliphron atlanticus
## Ln M=2.5+1.45ln LRL (British Antarctic Survey, unpublished data)
##
## Cirrata sp. A (Cherel) (no allometric equations available)
##
## Pareledone turqueti
## ML=17.70487+ 13.32812LHL; LnM =0.689269+2.542938LnLHL (n=7 for ML, n=23 for
## M), where LHL= lower hood length (in mm) (Collins, unpublished data)
## Adelieledone polymorpha
## ML= -7,426229508+25,16393443LHL; Ln M =1,077552+3,200449LnLHL
##  (n=3 for ML, n= 39 for M) (Collins, unpublished data)
## Benthoctopus thielei
## ML = 7.398+12.569LHL; lnM= 0.471+2.706lnLHL (n=48 for ML and M) (Cherel,
## unpublished data)
##
## Graneledone gonzalezi
## ML = 5.047+13.004LHL; lnM= 0.288+2.967lnLHL (n=54 for ML and M) (Cherel,
## unpublished data)
##
## Opisthoteuthis sp.
## ML=-26.0047+12.4858CL; logM=0.5893+0.2413CL (n= 13 for ML, n=9 for M) (Smale
## et al. 1993) where CL = Crest length (in mm)
##
## Stauroteuthis gilchristi (no allometric equations available)
##

    x
}

allometry_data <- build_allometry_df()
use_data(allometry_data,internal=FALSE,overwrite=TRUE)
