org 0x7e00
jmp 0x0000:start

section .start
		call hide_cursor ; Faz o campo
	start:
		call show_title
		call start_playing
		call show_game_over
		jmp start

start_playing:
        call reset		
        call buffer_clear
        call draw_border
        call create_initial_foods
    .main_loop:
        mov si, 2
        call sleep
    
        call update_snake_direction
        call update_snake_head
        call check_snake_new_position
        call print_score
        call buffer_render
    
        mov al, [is_game_over]
        cmp al, 0
        jz .main_loop
        ret

reset:
        mov ax, 0
        mov word [score], ax
        mov byte [is_game_over], al
        mov al, 8
        mov byte [snake_direction], al
        mov al, 40
        mov byte [snake_head_x], al
        mov byte [snake_head_previous_x], al
        mov byte [snake_tail_previous_x], al
        mov byte [snake_tail_x], al
        mov al, 15
        mov byte [snake_head_y], al
        mov byte [snake_head_previous_y], al
        mov byte [snake_tail_y], al
        mov byte [snake_tail_previous_y], al
        ret




show_title:
        call buffer_clear
        call buffer_render
        mov si, 18
        call sleep
        mov si, 0
    .next:
        mov bx, [.title + si]
        mov byte [buffer + bx], 219
        push si
        call buffer_render
        mov si, 1
        call sleep
        pop si
        add si, 2
        cmp si, 274
        jl .next
        mov si, .start_1
        mov di, 1626
        call buffer_print_string
        mov si, .start_2
        mov di, 1781
        call buffer_print_string
        call clear_keyboard_buffer
    .wait_for_key:
        mov si, .start_4
        mov di, 1388
        call buffer_print_string
        call buffer_render
        mov si, 5
        call sleep
        mov ah, 1
        int 16h
        jnz .continue
        mov si, .start_3
        mov di, 1388
        call buffer_print_string
        call buffer_render
        mov si, 10
        call sleep
        mov ah, 1
        int 16h
        jz .wait_for_key
    .continue:
        mov ah, 0
        int 16h
        ret
    .title: ; Snake
        dw 0342, 0341, 0340, 0339, 0338, 0337, 0336, 0335, 0415, 0495
        dw 0575, 0655, 0656, 0657, 0658, 0659, 0660, 0661, 0662, 0742
        dw 0822, 0902, 0982, 0981, 0980, 0979, 0978, 0977, 0976, 0975
        dw 0985, 0905, 0825, 0745, 0665, 0585, 0505, 0425, 0345, 0426
        dw 0507, 0587, 0668, 0669, 0750, 0830, 0911, 0992, 0912, 0832
        dw 0752, 0672, 0592, 0512, 0432, 0352, 0995, 0915, 0835, 0755
        dw 0675, 0595, 0515, 0435, 0355, 0356, 0357, 0358, 0359, 0360
        dw 0361, 0362, 0442, 0522, 0602, 0682, 0762, 0842, 0922, 1002
        dw 0676, 0677, 0678, 0679, 0680, 0681, 0365, 0445, 0525, 0605
        dw 0685, 0765, 0845, 0925, 1005, 0372, 0451, 0530, 0609, 0608
        dw 0687, 0686, 0768, 0769, 0850, 0931, 1012, 0382, 0381, 0380
        dw 0379, 0378, 0377, 0376, 0375, 0455, 0535, 0615, 0695, 0775
        dw 0855, 0935, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022
        dw 0696, 0697, 0698, 0699, 0700, 0701, 0702
    .start_1:
        db "Infraestrutura de Software", 0
        db "                      ", 0
    .start_2:
        db "Antonio Victor Bezerra Lucena <avbl>", 0
        db "Alysson Jose da Silva Ramos   <ajse>", 0
        db "Shell                               ", 0
        db "Thais Neves de Souza          <tns2>", 0
        ;db "WRITTEN IN ASSEMBLY 8086 LANGUAGE :)", 0
    .start_3:
        db "PRESS ANY KEY TO START", 0
    .start_4:
        db "                      ", 0











;
;
;
