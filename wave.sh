#!/usr/bin/env bash
# wave.sh: Add ~ character before specific patterns in LaTeX files
# Copyright (C) 217 Libor Polčák
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

function fix_file() {
	# Squeeze cite and ref at the beginning of a line to the previous line
	# See also https://stackoverflow.com/questions/12129870/how-can-i-remove-a-line-feed-newline-before-a-pattern-using-sed
	sed -i ':r;$!{N;br};s/\n\\cite/~\\cite/g' $1
	sed -i ':r;$!{N;br};s/\n\\ref/~\\ref/g' $1
	# Squeeze (number)\nsqueeze on the previous line
	sed -i ':r;$!{N;br};s/\(([0-9]+)\)\n/\1~/g' $1

	# Replace spaces before cite and ref
	sed -i 's/ \\cite/\~\\cite/g' $1
	sed -i 's/ \\ref/\~\\ref/g' $1
	# Replace spaces after (num) Something
	sed -i 's/\(([0-9]+)\) /\1~/g' $1
}

while [ $# -gt 0 ];
do
	fix_file $1
	shift
done
