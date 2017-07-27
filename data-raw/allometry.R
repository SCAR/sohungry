library(dplyr)
build_allometry_df <- function() {
    ## equations from Xavier and Cherel
    ## Ancistrocheirus lesueuri
    ## ML=-41.3+40.75LRL ; ln M=-0.194+3.56ln LRL (n=23 for ML, n=21 for M) (Clarke 1986)
    x <- tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                 "Ancistrocheirus lesueuri",138747,function(...)-41.3+40.75*...,"lower rostral length","mantle length","mm",23,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                 "Ancistrocheirus lesueuri",138747,function(...)exp(-0.194+3.56*log(...)),"lower rostral length","mass","g",21,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.")

    ## Architeuthis dux
    ## ML=-55.6+59.31LRL ; ln M=-1.773+4.57ln LRL (n=11 for ML; n=9 for M) (Clarke 1986)
    ## For relationships between ML and LRL, ML=10((LRL/11.2)+1.723214286) (n=43) might be
    ## better (Roeleveld 2000) with ML= mantle length (in mm), M= mass (in g) and LRL=
    ## lower rostral length (in mm).
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                             "Architeuthis dux",342218,function(...)-55.6+59.31*...,"lower rostral length","mantle length","mm",11,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Architeuthis dux",342218,function(...)exp(-1.773+4.57*log(...)),"lower rostral length","mass","g",9,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Architeuthis dux",342218,function(...)10^((.../11.2)+1.723214286),"lower rostral length","mantle length","mm",43,"Noted by Xavier & Cherel: this equation for mantle_length from LRL might be better than the Clarke (1986) one","Roeleveld (2000) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    ## Bathyteuthis abyssicola
    ## ML=1.68+51.59LRL; ln M=2.855+3.38ln LRL (n=17 for both ML and M) (Clarke 1986)
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                             "Bathyteuthis abyssicola",138848,function(...)1.68+51.59*...,"lower rostral length","mantle length","mm",17,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Bathyteuthis abyssicola",138848,function(...)exp(2.855+3.38*log(...)),"lower rostral length","mass","g",17,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    ## Batoteuthis skolops (no specific equations)
    ## May use formulas for close families
    ## ML=11.4+24.46LRL; ln M=-0.241+2.7ln LRL (n=23 for ML, n=14 for M) (Clarke 1986),
    ## based on Chiroteuthis spp. formulas
    ## ML=-1.8+29.08LRL ; ln M=0.184+2.88ln LRL (n=47 for ML, n=45 for M) (Clarke 1986),
    ## based on Mastigoteuthis spp. formulas
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                             "Batoteuthis skolops",325293,function(...)11.4+24.46*...,"lower rostral length","mantle length","mm",23,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Batoteuthis skolops",325293,function(...)exp(-0.241+2.7*log(...)),"lower rostral length","mass","g",14,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Batoteuthis skolops",325293,function(...)-1.8+29.08*...,"lower rostral length","mantle length","mm",47,"Based on Mastigoteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Batoteuthis skolops",325293,function(...)exp(0.184+2.88*log(...)),"lower rostral length","mass","g",45,"Based on Mastigoteuthis spp. formula from Clarke (1986). There are no specific equations for Batoteuthis skolops","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    ## ML= 16.31+20.18LRL ; ln M=0.55+1.41ln LRL (n= 11 for both ML and M) (Clarke 1986)
    ## for the species of the family Brachioteuthidae
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                             "Brachioteuthidae",11758,function(...)16.31+20.18*...,"lower rostral length","mantle length","mm",11,"Applies to species of the family Brachioteuthidae","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Brachioteuthidae",11758,function(...)exp(0.55+1.41*log(...)),"lower rostral length","mass","g",11,"Applies to species of the family Brachioteuthidae","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))
    ## note that this will require some additional coding in the user function, so that e.g. an input taxon_name of "Brachioteuthis picta" will find its way to this equation even though it does not directly match the taxon_name or aphia_id specified here


    ## Chiroteuthis veranyi (no specific equations)
    ## ML=11.4+24.46LRL ; ln M=-0.241+2.7 ln LRL (n=23 for ML, n=14 for M) (Clarke 1986), based on Chiroteuthis spp. formulas
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return_measurement,~units,~N,~notes,~reference,
                             "Chiroteuthis veranii",139125,function(...)11.4+24.46*...,"lower rostral length","mantle length","mm",23,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Chiroteuthis veranii",139125,function(...)exp(-0.241+2.7*log(...)),"lower rostral length","mass","g",14,"Based on Chiroteuthis spp. formula from Clarke (1986). There are no specific equations for Chiroteuthis veranii","Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    x
}

allometry_data <- build_allometry_df()
use_data(allometry_data,internal=TRUE,overwrite=TRUE)
