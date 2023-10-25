org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A             

start:
    jmp         main   

puts:
    ;save registers we use to the stack
    push        si              ;save si
    push        ax              ;save ax

.loop:
    ;load the next character
    lodsb                       ;load next character into al
    or          al, al          ;check if al is 0
    jz         .done            ;if al is 0, we're done

    mov         ah, 0x0e        ;call bios interupt
    int         0x10            ;print character

    jmp         .loop       

.done:
    ;restore registers
    pop         ax              
    pop         si
    ret

main:
                        
    ;setup data segments
    mov         ax, 0           
    mov         ds, ax          
    mov         es, ax          
    ;setup stack
    mov         ss, ax          
    mov         sp, 0x7C00      
    ;print message
    mov         si, msg_hello    
    call        puts   

    hlt                         


.halt:
    jmp .halt


msg_hello: db 'Hello World! hhhh $$', ENDL, 0

;Pad the boot sector to 510 bytes and add the boot sector signature
;Boot sector signature
times 510-($-$$) db 0                   
dw 0AA55h
