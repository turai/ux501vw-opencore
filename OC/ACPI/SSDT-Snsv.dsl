// Hybrid GPU disable: https://raw.githubusercontent.com/dortania/Getting-Started-With-ACPI/master/extra-files/decompiled/SSDT-NoHybGfx.dsl
// GPRW (USB instant wakeup) patch: https://github.com/dortania/OpenCore-Post-Install/blob/master/extra-files/SSDT-GPRW.aml
// Fake EC: https://github.com/dortania/Getting-Started-With-ACPI/blob/master/extra-files/decompiled/SSDT-EC-LAPTOP.dsl
// XOSI: https://github.com/dortania/Getting-Started-With-ACPI/blob/master/extra-files/decompiled/SSDT-XOSI.dsl

DefinitionBlock("", "SSDT", 1, "TURAI", "SNSV", 0x00000001) {
    External(_SB_.PCI0.PEG0.PEGP._DSM, MethodObj)
    External(_SB_.PCI0.PEG0.PEGP._PS3, MethodObj)
    External(_SB_.PCI0.LPCB, DeviceObj)
    External(_SB_.PCI0.LPCB.EC0.WRAM, MethodObj)
    External(_SB_.PCI0.LPCB.EC0, DeviceObj)
    External(_SB_.ATKD, DeviceObj)
    External(_SB_.ATKD.IANE, MethodObj)
    External(ATKP, IntObj)
    External(XPRW, MethodObj)
    External(_SB_.PCI0.GPI0, DeviceObj)
    External(_SB_.PCI0.I2C1.ETPD, DeviceObj)
    External(_SB_.PCI0.RP02.PXSX._OFF, MethodObj) // Card reader

    Method (XOSI, 1, NotSerialized) {
        Local0 = Package (0x11) {
                "Windows 2001", 
                "Windows 2001.1", 
                "Windows 2001 SP1", 
                "Windows 2001 SP2", 
                "Windows 2001 SP3", 
                "Windows 2006", 
                "Windows 2006 SP1", 
                "Windows 2009", 
                "Windows 2012", 
                "Windows 2013", 
                "Microsoft Windows NT", 
                "Microsoft Windows", 
                "Microsoft WindowsME: Millennium Edition"
            }
        If(_OSI("Darwin")) {
            Return ((Ones != Match (Local0, MEQ, Arg0, MTR, Zero, Zero)))
        }
        
        Return (_OSI(Arg0))
    }


    Device(ALS0) {
        Name(_HID, "ACPI0008")
        Name(_CID, "smc-als")
        Name(_ALI, 150)
        Name(_ALR, Package() {
            Package() { 100, 150 }
        })
    }
    
    Device(ZRD1) {
        Name(_HID, "ZRD10000")
        Method(_INI, 0, NotSerialized) {
            if(_OSI("Darwin")) {
                If((CondRefOf(\_SB.PCI0.PEG0.PEGP._DSM) && CondRefOf(\_SB.PCI0.PEG0.PEGP._PS3))) {
                    \_SB.PCI0.PEG0.PEGP._DSM(ToUUID("a486d8f8-0bda-471b-a72b-6042a6b5bee0"), 0x0100, 0x1A, Buffer (0x04) {
                        0x01, 0x00, 0x00, 0x03                         
                    })
                    \_SB.PCI0.PEG0.PEGP._PS3()
                }
                
                //if(CondRefOf(\_SB.PCI0.RP02.PXSX._DSM)) {
                //    \_SB.PCI0.RP02.PXSX._DSM(ToUUID("1730e71d-e5dd-4a34-be57-4d76b6a2fe37"), Zero, One, Buffer(0x01) {
                //        One
                //    })
                //}
            }
        }
        Method(_STA, 0, NotSerialized) {
            if(_OSI("Darwin")) {
                Return (0x0F)
            }
            
            Return (Zero)
        }
    }
    
    Scope(\_SB.PCI0.LPCB) {
        Device(EC) {
            Name(_HID, "ACID0001")
            Method(_STA, 0, NotSerialized) {
                if(_OSI("Darwin")) {
                    Return (0x0F)
                }
                
                Return (Zero)
            }
        }
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

    Method(GPRW, 2, NotSerialized) {
        if(_OSI("Darwin")) {
            if((0x6D == Arg0)) {
                Return (Package(0x02) { 0x6D, Zero })
            }
            
            if((0x0D == Arg0)) {
                Return (Package(0x02) { 0x0D, Zero })
            }
        }
        
        Return (XPRW(Arg0, Arg1))
    }

    Scope(_SB.PCI0.GPI0) {
        Method(_STA, 0, NotSerialized) {
            Return (0x0F)
        }
    }

    Scope (_SB.PCI0.I2C1.ETPD) {
        Method(_CRS, 0, Serialized) {
            Name (LBFG, ResourceTemplate() {
                GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000, "_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,) {
                    0x0047
                }
            })
            Name (LBFI, ResourceTemplate() {
                I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A80, AddressingMode7Bit, "\\_SB.PCI0.I2C1", 0x00, ResourceConsumer, , Exclusive, )
            })
            Return (ConcatenateResTemplate (LBFI, LBFG))
        }
    }

}