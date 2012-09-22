###############################################################################
# nCHandle is instance pointer of ConstraintManager
# nComIdXbd is the TE0600
# nDesignID is the HURRI design
proc RunUcfConstraintGen { nCHandle nComIdXbd nDesignId } {
   set nResult 0

   if { $nCHandle eq "" } {
      return $nResult
  }

   if { $nComIdXbd eq "" } {
      return $nResult
   }

   if { $nDesignId eq "" } {
      return $nResult
   }

   set bApiStatus [ tgi::init "1.0" "fail" "Client connected" ]
   if { $bApiStatus == 0 } {
      return 1
   }
   
   # Repository path
   set strRepoDirPath [ bsb::getRepoDirPath $nCHandle ]

   # Pin Constraints
   set strCsvFilePath [ file join $strRepoDirPath "te0600_01v_pins.csv" ]

   set nResult [ \
      bsb::registerPinData $nCHandle $nComIdXbd $nDesignId $strCsvFilePath \
   ]

   if { $nResult != 0 } {
      return $nResult
   }

   # Additional Constraints
   
   # TEMAC - axi_ethernet
   set strUcfFilePath [ \
      file join $strRepoDirPath "Soft_TEMAC_axi_ethernet_v1_00_a.ucf" \
   ]
   set vecBusIf [list "ETHERNET" $strUcfFilePath]

   set nResult [ \
         bsb::registerRawUcfFileForBusIf \
            $nCHandle $nDesignId $vecBusIf \
      ]

   if { $nResult != 0 } {
      return $nResult
   }

   # MCB_DDR3
   set strUcfFilePath [ \
      file join $strRepoDirPath "MCB_DDR3.ucf"
   ]
   set vecBusIf [list "MCB1_DDR3" $strUcfFilePath]

   set nResult [ \
         bsb::registerRawUcfFileForBusIf \
            $nCHandle $nDesignId $vecBusIf \
      ]

   if { $nResult != 0 } {
      return $nResult
   }

   # Indicate that we are done.
   #tgi::end 0 "Client done"

   return $nResult
}
###############################################################################
