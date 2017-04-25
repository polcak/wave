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

function fix_problem_beginning {
	FIND=$1
	FILE=$2

	# See also https://stackoverflow.com/questions/12129870/how-can-i-remove-a-line-feed-newline-before-a-pattern-using-sed
	sed -i ":r;\$!{N;br};s/\n *${FIND}/~${FIND}/g" "$FILE"
	sed -i "s/ ${FIND}/~${FIND}/g" "$FILE"
}

function fix_problem_end {
	FIND=$1
	FILE=$2

	# See also https://stackoverflow.com/questions/12129870/how-can-i-remove-a-line-feed-newline-before-a-pattern-using-sed
	sed -i ":r;\$!{N;br};s/\(${FIND}\)\n/\1~/g" "$FILE"
	sed -i "s/\(${FIND}\) \b/\1~/g" "$FILE"
}

function fix_file() {
	# Fix \cite and \ref
	fix_problem_beginning '\\cite' $1
	fix_problem_beginning '\\ref' $1
	# Squeeze (number)\nsqueeze on the previous line
	fix_problem_end '([0-9]\+)' $1

	# Some of the https://english.stackexchange.com/questions/67089/english-line-breaking-rules
	fix_problem_end '\ba\b' $1
	#fix_problem_end '\ban\b' $1
	#fix_problem_end '\bthe\b' $1
	#fix_problem_end '\bwhich\b' $1
	#fix_problem_end '\bthat\b' $1
	#fix_problem_end '\bwho\b' $1
}

while [ $# -gt 0 ];
do
	fix_file $1
	shift
done
