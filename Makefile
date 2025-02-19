CC = gcc
CXX = g++

OUTPUT := xinput1_3.dll
OUTPUT_COPY := "/c/Program Files (x86)/Steam/steamapps/common/DB Xenoverse 2/bin/xinput1_3.dll"

OBJS=main.o debug.o cpk_patch.o UtfLowLevel.o chara_patch.o stage_patch.o autogenportrait_dumper.o ai_patch.o ui_patch.o fs_event_offline.o item_patch.o 
OBJS += mob_control.o quest.o chara_patch_asm.o fs_event_offline_asm.o
OBJS += ../eternity_common/crypto/sha1.o ../eternity_common/crypto/md5.o ../eternity_common/crypto/rijndael.o
OBJS += ../eternity_common/Utils.o ../eternity_common/BaseFile.o ../eternity_common/IniFile.o
OBJS += ../eternity_common/Stream.o ../eternity_common/MemoryStream.o ../eternity_common/FixedMemoryStream.o ../eternity_common/FileStream.o
OBJS += ../eternity_common/PatchUtils.o ../eternity_common/EPatchFile.o
OBJS += ../eternity_common/Misc/IggyFile.o
OBJS += ../eternity_common/DBXV2/MsgFile.o ../eternity_common/DBXV2/IdbFile.o ../eternity_common/DBXV2/QsfFile.o
OBJS += ../eternity_common/DBXV2/Xv2PreBakedFile.o ../eternity_common/DBXV2/Xv2StageDefFile.o ../eternity_common/DBXV2/Xv2PatcherSlotsFile.o
OBJS += ../eternity_common/tinyxml/tinyxml.o ../eternity_common/tinyxml/tinystr.o ../eternity_common/tinyxml/tinyxmlerror.o ../eternity_common/tinyxml/tinyxmlparser.o
CFLAGS +=-Wall -I. -I../eternity_common -std=gnu99 -mms-bitfields -s -O2 -masm=intel -shared -Wl,--subsystem,windows,--kill-at,--enable-stdcall-fixup
CFLAGS += -static -static-libgcc -static-libstdc++
CFLAGS += -DXV2 
CXXFLAGS +=-Wall -Wno-strict-aliasing -I../eternity_common -I../eternity_common/DBXV2 -O2 -std=c++11 -mms-bitfields -DTIXML_USE_STL -DXV2_STAGEDEF_SIMPLE -DIDB_SIMPLE
CXXFLAGS += -static-libgcc -static-libstdc++ -static -Wl,--subsystem,windows,--kill-at 
CPPFLAGS += -DXV2 -DNO_ZLIB 
LDFLAGS=-L. -static xinput.def
LIBS = -lstdc++ -lversion -lminhook

all: $(OUTPUT)	
	cp $(OUTPUT) $(OUTPUT_COPY)

clean:
	rm -f $(OUTPUT) *.o
	rm -f ../eternity_common/*.o
	rm -f ../eternity_common/Misc/*.o
	rm -f ../eternity_common/DBXV2/*.o
	rm -f ../eternity_common/tinyxml/*.o	
	rm -f ../eternity_common/crypto/*.o

$(OUTPUT): $(OBJS)
	$(LINK.c) $(LDFLAGS) -o $@ $^ $(LIBS)

