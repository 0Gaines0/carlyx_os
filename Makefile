ASM=nasm

BOOTLOADER_DIR= src/bootloader
BUILD_DIR=build

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main.bin: $(BOOTLOADER_DIR)/main.asm
	$(ASM) $(BOOTLOADER_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin

