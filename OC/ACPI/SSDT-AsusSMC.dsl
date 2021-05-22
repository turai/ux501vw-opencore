DefinitionBlock("", "SSDT", 1, "TURAI", "ASUSSMC", 0x00000001) {
    External(_SB_.PCI0.LPCB.EC0.WRAM, MethodObj)
    External(_SB_.PCI0.LPCB.EC0, DeviceObj)
    External(_SB_.ATKD, DeviceObj)
    External(_SB_.ATKD.IANE, MethodObj)
    External(ATKP, IntObj)

    Device(ALS0) {
        Name(_HID, "ACPI0008")
        Name(_CID, "smc-als")
        Name(_ALI, 150)
        Name(_ALR, Package() {
            Package() { 100, 150 }
        })
    }
    
    // Enable keyboard backlight (SKBV is the method AsusSMC is looking for)
    Scope(\_SB.ATKD) {
        Method(SKBV, 1, NotSerialized) {
            \_SB.PCI0.LPCB.EC0.WRAM(0x04B1, Arg0)
            Return (Arg0)
        }
    }
    
    // Other keys work on my machine without patching
    Scope(\_SB.PCI0.LPCB.EC0) {
        // F2 - Airplane mode
        Method(_Q0B, 0, NotSerialized) {
            if(ATKP) {
                \_SB.ATKD.IANE(0x7D)
            }
        }
        
        // F3 - Keyboard brighness down
        Method(_Q0C, 0, NotSerialized) {
            if(ATKP) {
                \_SB.ATKD.IANE(0xC5)
            }
        }
        
        // F4 - Keyboard brightness up
        Method(_Q0D, 0, NotSerialized) {
            if(ATKP) {
                \_SB.ATKD.IANE(0xC4)
            }
        }
        
        // F5 - Screen brightness down
        Method(_Q0E, 0, NotSerialized) {
            if(ATKP) {
                \_Sb.ATKD.IANE(0x20)
            }
        }
        
        // F6 - Screen brightness up
        Method(_Q0F, 0, NotSerialized) {
            if(ATKP) {
                \_Sb.ATKD.IANE(0x10)
            }
        }
        
        // F8 - Switch to ext. screen
        Method(_Q11, 0, NotSerialized) {
            if(ATKP) {
                \_Sb.ATKD.IANE(0x61)
            }
        }
    }
}