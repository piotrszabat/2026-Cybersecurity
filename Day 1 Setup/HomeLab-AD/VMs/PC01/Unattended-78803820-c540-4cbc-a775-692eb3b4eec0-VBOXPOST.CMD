@echo off
rem $Id: win_postinstall.cmd 164827 2024-09-16 14:03:52Z bird $
rem rem @file
rem Post installation script template for Windows.
rem
rem This runs after the target system has been booted, typically as
rem part of the first logon.
rem

rem
rem Copyright (C) 2017-2024 Oracle and/or its affiliates.
rem
rem This file is part of VirtualBox base platform packages, as
rem available from https://www.virtualbox.org.
rem
rem This program is free software; you can redistribute it and/or
rem modify it under the terms of the GNU General Public License
rem as published by the Free Software Foundation, in version 3 of the
rem License.
rem
rem This program is distributed in the hope that it will be useful, but
rem WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
rem General Public License for more details.
rem
rem You should have received a copy of the GNU General Public License
rem along with this program; if not, see <https://www.gnu.org/licenses>.
rem
rem SPDX-License-Identifier: GPL-3.0-only
rem

rem Globals.
set MY_LOG_FILE=C:\vboxpostinstall.log

rem Log header.
echo *** started >> %MY_LOG_FILE%
echo *** CD=%CD% >> %MY_LOG_FILE%
echo *** Environment BEGIN >> %MY_LOG_FILE%
set >> %MY_LOG_FILE%
echo *** Environment END >> %MY_LOG_FILE%











rem
rem Eject/rename no longer needed unattended install configuration and media.
rem
if exist a:\autounattend.xml ren a:\autounattend.xml autounattend-disabled.xml
rem rem @todo eject DVD install media

echo *** done >> %MY_LOG_FILE%

