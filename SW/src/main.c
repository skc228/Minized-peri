/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xuartps.h"
#include "platform.h"
#include "xil_printf.h"
#include <xparameters.h>


// XPAR_XBRAM_0_BASEADDR            0x6000_0000
// XPAR_XGPIO_0_BASEADDR            0x6001_0000
// XPAR_USER_M_AXI_LITE_0_BASEADDR  0X4000_0000


int main()
{
    init_platform(); 
/*
// Initial Helloworld Code

    print("Hello World\n\r");
    print("Successfully ran Hello World application\n\r");
*/
    int count = 0;
    int read_data;
    int write_data;

    // Step 0 : AXI BRAM Read, Write Data Check 
    xil_printf("Step 0 : AXI BRAM Data Check\n\r");
    read_data = *((int *) (XPAR_XBRAM_0_BASEADDR));
    xil_printf("Before Write, AXI BRAM Read Data : %d\n\r", read_data);
    write_data = 0x01234567;
    *((int *) (XPAR_XBRAM_0_BASEADDR)) = write_data;
    read_data = *((int *) (XPAR_XBRAM_0_BASEADDR));
    xil_printf("After Write, AXI BRAM Read Data : %d\n\r", read_data);
    // Step 1 : AXI GPIO LED Control Check 
    xil_printf("Step 1 : AXI GPIO LED  Check\n\r");
    for (int i = 0 ; i < 10 ; i++){
        while (count < 80000000){
            count++;
            if (count == 20000000){
                write_data = 0x1;
                *((int *) XPAR_XGPIO_0_BASEADDR) = write_data; // RED
            }

            else if(count == 40000000){
                write_data = 0x0;
                *((int *) XPAR_XGPIO_0_BASEADDR) = write_data; // RED
            }

            else if(count == 60000000) {
                write_data = 0x1;
                *((int *) (XPAR_XGPIO_0_BASEADDR + 8)) = write_data; // GREEN
            }

            else if(count == 80000000) {
                write_data = 0x0;
                *((int *) (XPAR_XGPIO_0_BASEADDR + 8)) = write_data; // GREEN
            }
        }
        count = 0;
    }

    // Step 2 : AXI LITE REG  
    xil_printf("Step 2 : AXI LITE REG (PERI) Check\n\r");
    // SRC_A_REG Write
    write_data = 15; 
    *((int *) (XPAR_USER_M_AXI_LITE_0_BASEADDR + 0)) = write_data;
    // SRC_B_REG Write
    write_data = 4; 
    *((int *) (XPAR_USER_M_AXI_LITE_0_BASEADDR + 4)) = write_data;

    // ADD
    read_data = *((int *) (XPAR_USER_M_AXI_LITE_0_BASEADDR + 8));
    xil_printf("ADD (A + B) Results : %d\n\r", read_data);
    // SUB
    read_data = *((int *) (XPAR_USER_M_AXI_LITE_0_BASEADDR + 12));
    xil_printf("SUB (A - B) Results : %d\n\r", read_data);
    // MULT
    read_data = *((int *) (XPAR_USER_M_AXI_LITE_0_BASEADDR + 16));
    xil_printf("MULT (A * B) Results : %d\n\r", read_data);


    cleanup_platform();
    return 0;
}
