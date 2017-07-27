library(dplyr)
build_allometry_df <- function() {
    ## equations from Xavier and Cherel
    ## Ancistrocheirus lesueuri
    ## ML=-41.3+40.75LRL ; ln M=-0.194+3.56ln LRL (n=23 for ML, n=21 for M) (Clarke 1986)
    x <- tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return,~units,~N,~notes,~reference,
                 "Ancistrocheirus lesueuri",138747,function(...)-41.3+40.75*...,"lower rostral length","mantle length","mm",23,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                 "Ancistrocheirus lesueuri",138747,function(...)exp(-0.194+3.56*log(...)),"lower rostral length","mass","g",21,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.")

    ## Architeuthis dux
    ## ML=-55.6+59.31LRL ; ln M=-1.773+4.57ln LRL (n=11 for ML; n=9 for M) (Clarke 1986)
    ## For relationships between ML and LRL, ML=10((LRL/11.2)+1.723214286) (n=43) might be
    ## better (Roeleveld 2000) with ML= mantle length (in mm), M= mass (in g) and LRL=
    ## lower rostral length (in mm).
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return,~units,~N,~notes,~reference,
                             "Architeuthis dux",342218,function(...)-55.6+59.31*...,"lower rostral length","mantle length","mm",11,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Architeuthis dux",342218,function(...)exp(-1.773+4.57*log(...)),"lower rostral length","mass","g",9,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Architeuthis dux",342218,function(...)10^((.../11.2)+1.723214286),"lower rostral length","mantle length","mm",43,"Noted by Xavier & Cherel: this equation for mantle_length from LRL might be better than the Clarke (1986) one","Roeleveld (2000) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    ## Bathyteuthis abyssicola
    ## ML=1.68+51.59LRL; ln M=2.855+3.38ln LRL (n=17 for both ML and M) (Clarke 1986)
    x <- bind_rows(x,tribble(~taxon_name,~aphia_id,~equation,~input_measurement,~return,~units,~N,~notes,~reference,
                             "Bathyteuthis abyssicola",138848,function(...)1.68+51.59*...,"lower rostral length","mantle length","mm",17,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp.",
                             "Bathyteuthis abyssicola",138848,function(...)exp(2.855+3.38*log(...)),"lower rostral length","mass","g",17,"","Clarke (1986) in Xavier J & Cherel Y (2009 updated 2016) Cephalopod beak guide for the Southern Ocean. Cambridge, British Antarctic Survey, 129pp."))

    x
}

allometry_data <- build_allometry_df()
use_data(allometry_data,internal=TRUE,overwrite=TRUE)
