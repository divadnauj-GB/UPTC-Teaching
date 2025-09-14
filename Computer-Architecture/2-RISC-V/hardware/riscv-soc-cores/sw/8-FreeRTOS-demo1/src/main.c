#include "FreeRTOS.h"
#include "task.h"
#include "uart.h"


#define LED_PORT	( *(volatile uint32_t *) 0x91000000 )
volatile unsigned char gpio_state=0;
// Define the LED pin and toggle period
#define BLINK1_PERIOD_MS 500
#define BLINK2_PERIOD_MS 300

void vBlinkTask(void *pvParameters) {
    // Initialize LED pin as output (using your specific HAL functions)

    for (;;) {
        // Toggle LED (using your specific HAL functions)
        gpio_state^=0xA0;
		LED_PORT = gpio_state;
		uart_puts("Blink task 1\n");
        // Delay for the blink period
        vTaskDelay(pdMS_TO_TICKS(BLINK1_PERIOD_MS));
    }
}

void vBlinkTask2(void *pvParameters) {
    // Initialize LED pin as output (using your specific HAL functions)

    for (;;) {
        // Toggle LED (using your specific HAL functions)
        gpio_state^=0x0A;
		LED_PORT = gpio_state;
		uart_puts("Blink task 2\n");
        // Delay for the blink period
        vTaskDelay(pdMS_TO_TICKS(BLINK2_PERIOD_MS));
    }
}

int main(void) {
    // System initialization (clocks, peripherals, etc.)
	uart_init();
	gpio_state=0xE0;
	LED_PORT = gpio_state;
    // Create the LED blink task
    xTaskCreate(vBlinkTask, "Blinky1", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY + 1, NULL);
	xTaskCreate(vBlinkTask2, "Blinky2", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY + 1, NULL);

    // Start the FreeRTOS scheduler
    vTaskStartScheduler();

    // Should never reach here
    for (;;) {}
}

void vApplicationMallocFailedHook( void )
{
	/* vApplicationMallocFailedHook() will only be called if
	configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
	function that will get called if a call to pvPortMalloc() fails.
	pvPortMalloc() is called internally by the kernel whenever a task, queue,
	timer or semaphore is created.  It is also called by various parts of the
	demo application.  If heap_1.c or heap_2.c are used, then the size of the
	heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
	FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
	to query the size of free heap space that remains (although it does not
	provide information on how the remaining heap might be fragmented). */
	taskDISABLE_INTERRUPTS();
	uart_puts("vApplicationMallocFailedHook\n");
	__asm volatile( "ebreak" );
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook( void )
{
	/* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
	to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
	task.  It is essential that code added to this hook function never attempts
	to block in any way (for example, call xQueueReceive() with a block time
	specified, or call vTaskDelay()).  If the application makes use of the
	vTaskDelete() API function (as this demo application does) then it is also
	important that vApplicationIdleHook() is permitted to return to its calling
	function, because it is the responsibility of the idle task to clean up
	memory allocated by the kernel to any task that has since been deleted. */
}
/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName )
{
	( void ) pcTaskName;
	( void ) pxTask;

	/* Run time stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
	function is called if a stack overflow is detected. */
	taskDISABLE_INTERRUPTS();
	uart_puts("vApplicationStackOverflowHook!!\n");
	__asm volatile( "ebreak" );
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
	// User code can be placed here
	
}
/*-----------------------------------------------------------*/

void freertos_risc_v_application_interrupt_handler( uint32_t mcause )
{
	// User code can be placed here
	uart_puts("freertos_risc_v_application_interrupt_handler!!\n");
}
/*-----------------------------------------------------------*/