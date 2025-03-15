source('queries.R')

# SRF Storage Wells
well_names <- c('GS SRU KGSF 001', 'GS SRU KGSF 007A',
                'GS SCU 042-05X', 'GS SCU 042-05Y',
                'GS SCU 042-05Z',
                # Injection
                'GS SRU KGSF 001 Injection', 'GS SRU KGSF 007A Injection',
                'GS SCU 042-05X Injection Well', 'GS SCU 042-05Y Injection')

well_reservoir <- c('Tyonek 64-5', 'Tyonek 64-5',
                    'Tyonek 77-3', 'Tyonek 77-3', 
                    'Tyonek 77-3', 
                    # Injection
                    'Tyonek 64-5', 'Tyonek 64-5',
                    'Tyonek 77-3', 'Tyonek 77-3')

well <- c('KGSF 1A', 'KGSF 7A',
          'SCU 42-05X', 'SCU 42-05Y',
          'SCU 42-05Z', 'KGSF 1A', 
          'KGSF 7A', 'SCU 42-05X', 
          'SCU 42-05Y')

wi <- data.frame(key = rep('none', length(well_names)),
                 lookup = well_names,
                 res = well_reservoir,
                 well = well)

prd_list <- list()
for(i in 1:nrow(wi)) {
  well_name = wi[i, 'lookup']
  
  press = wellPressures(well_name)
  
  if(grepl('Inj', well_name)) {
    injEn = wellInjectionEnertia(well_name)
    injUom = wellInjectionUOM(well_name)
    inj = rbind(injEn, injUom)
    
    prd_list[[length(prd_list) + 1]] = inj
    
  } else {
    prodEn = wellProductionEnertia(well_name)
    prodUom = wellProductionUOM(well_name)
    prod = rbind(prodEn, prodUom)
    
    prd_list[[length(prd_list) + 1]] = prod
  }
  print(i)
}
