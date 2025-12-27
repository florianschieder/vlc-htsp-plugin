PREFIX = /usr
LD = ld
CC = gcc
CXX = g++
INSTALL = install
CFLAGS = -pipe -O2 -Wall -Wextra -std=gnu99 -I. -g
CXXFLAGS = -pipe -O2 -Wall -Wextra -std=gnu++0x -I. -g
LDFLAGS = -Wl,-no-undefined,-z,defs -latomic
VLC_PLUGIN_CFLAGS := $(shell pkg-config --cflags vlc-plugin)
VLC_PLUGIN_LIBS := $(shell pkg-config --libs vlc-plugin)
VLC_PLUGIN_MAJOR := $(shell pkg-config --modversion vlc-plugin | cut -d . -f 1)
VLC_PLUGIN_MINOR := $(shell pkg-config --modversion vlc-plugin | cut -d . -f 2)

libdir = $(PREFIX)/lib
plugindir = $(libdir)/vlc/plugins

override CFLAGS += -DMODULE_STRING=\"htsp\" -DVLC_PLUGIN_MAJOR=$(VLC_PLUGIN_MAJOR) -DVLC_PLUGIN_MINOR=$(VLC_PLUGIN_MINOR)
override CXXFLAGS += -DMODULE_STRING=\"htsp\" -DVLC_PLUGIN_MAJOR=$(VLC_PLUGIN_MAJOR) -DVLC_PLUGIN_MINOR=$(VLC_PLUGIN_MINOR)
override CFLAGS += $(VLC_PLUGIN_CFLAGS)
override CXXFLAGS += $(VLC_PLUGIN_CFLAGS)
override LDFLAGS += $(VLC_PLUGIN_LIBS)

TARGETS = libhtsp_plugin.so
C_SOURCES = sha1.c
CXX_SOURCES = vlc-htsp-plugin.cpp htsmessage.cpp helper.cpp access.cpp discovery.cpp

all: libhtsp_plugin.so

install: all
	mkdir -p -- "$(DESTDIR)$(plugindir)/services_discovery"
	$(INSTALL) --mode 0755 libhtsp_plugin.so "$(DESTDIR)$(plugindir)/services_discovery"

install-strip:
	$(MAKE) install INSTALL="$(INSTALL) -s"

uninstall:
	rm -f "$(DESTDIR)$(plugindir)/services_discovery/libhtsp_plugin.so"

clean:
	rm -f -- libhtsp_plugin.{dll,so} *.o

mostlyclean: clean

%.o: %.c
	$(CC) $(CFLAGS) -DPIC -fPIC -c $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -DPIC -fPIC -c $<

libhtsp_plugin.so: $(C_SOURCES:%.c=%.o) $(CXX_SOURCES:%.cpp=%.o)
	$(CXX) -shared -o $@ $(C_SOURCES:%.c=%.o) $(CXX_SOURCES:%.cpp=%.o) $(LDFLAGS)

.PHONY: all install install-strip uninstall clean mostlyclean win32 osx

