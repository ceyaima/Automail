m4_divert(-1)m4_dnl
m4_changequote(<m4<,>m4>)
m4_define(AUTOMAIL_VERSION,10.6.4)
m4_divert(0)m4_dnl
// ==UserScript==
// @name         Automail
// @namespace    http://tampermonkey.net/
// @version      AUTOMAIL_VERSION
// @description  Extra parts for Anilist.co
// @description:nn-NO Ekstradelar for Anilist.co
// @author       hoh
// @match        https://anilist.co/*
// @grant        GM_xmlhttpRequest
// @license      GPL-3.0-or-later
// ==/UserScript==
// SPDX-FileCopyrightText: 2019-2023 hoh and the Automail contributors
//
// SPDX-License-Identifier: GPL-3.0-or-later
(function(){
"use strict";
const scriptInfo = {
	"version" : "AUTOMAIL_VERSION",
	"name" : "Automail",
	"link" : "https://greasyfork.org/en/scripts/370473-automail",
	"repo" : "https://github.com/hohMiyazawa/Automail",
	"firefox" : "https://github.com/hohMiyazawa/Automail/releases",
	"chrome" : "NO KNOWN BUILDS",
	"author" : "hoh",
	"authorLink" : "https://anilist.co/user/hoh/",
	"license" : "GPL-3.0-or-later"
};
/*
	A collection of enhancements for Anilist.co
*/
/*
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	<https://www.gnu.org/licenses/>.
*/
/*
"useScripts" contains the defaults for many modules. This is stored in the user's localStorage.
(development debugging tip: if you enable "Enable an API for other scripts to control this script" in the settings, the settings object will be exposed in the DOM as document.automailAPI.document.automailAPI.settings)
Many of the modules are closely tied to the Anilist API
Other than that, some data loaded from MyAnimelist is the only external resource (opt-in)

Optionally, a user may give the script higher privileges (e.g, editing list data) through the Anilist grant system, enabling some additional modules
*/
const script_type = "Automail"

/* GENERAL STRUCTURE:
 1. Settings
 2. CSS
 3. tools and helper functions
 4. The old modules, as individual callable functions
 5. The URL matcher, for making the modules run at the right sites
 6. Old module descriptions
 7. The new modules
*/
m4_include(settings.js)
m4_include(alias.js)
//a shared style node for all the modules. Most custom classes are prefixed by "hoh" to avoid collisions with native Anilist classes
let style = document.createElement("style");
style.id = "automail-styles";
style.type = "text/css";

//The default colour is rgb(var(--color-blue)) provided by Anilist, but rgb(var(--color-green)) is preferred for things related to manga
style.textContent = `
m4_include(css/global.css)
`;
let documentHead = document.querySelector("head");
if(documentHead && document.URL !== "https://anilist.co/graphiql"){
	documentHead.appendChild(style)
}
else{
	return//xml documents or something. At least it's not a place where the script can run
}
m4_include(polyfills.js)
m4_include(localisation.js)
m4_include(conditionalStyles.js)
m4_include(utilities.js)
m4_include(purify.js)
m4_include(graphql.js)
m4_include(cache.js)
m4_include(controller.js)
m4_include(build/userModules.js)
m4_include(HOWTO.js)
})()
//wanna translate Automail? https://github.com/hohMiyazawa/Automail/issues/69
