# Redmine Changelog

Provides a wiki macro to generate a changelog for a project

![Changelog](img/redmine_changelog.png "Changelog")

## Installation

1. Clone this repository to the plugins/redmine_changes
1. Restart the server (migration not required)

## Usage

{{changelog()}}: generates a changelog showing issues closed on a given target 
revision.

{{changelog(false)}}: do not include the issue number/link in the listing

This generates a text based version of the roadmap that can be used for version
documenation.

## License

This program is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
