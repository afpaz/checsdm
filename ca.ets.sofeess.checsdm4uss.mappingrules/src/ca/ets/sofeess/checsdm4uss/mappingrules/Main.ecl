/*
 * Copyright (c) 2016-2019 ÉTS
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     https://www.apache.org/licenses/LICENSE-2.0
 *     
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */ 

/**
 * @author: Andrés Paz
 */

import "Common.ecl";
import "ClassesAndSubsystems.ecl";
import "StateMachinesAndCharts.ecl";

pre {
	var stringComparator = new Native("org.apache.commons.text.similarity.JaroWinklerDistance");
	"> Applying mapping rules...".println();
	"".println();
}

post {
	"> Building mapping model...".println();
	"".println();
	
	var mm : new Mappings!MappingsModel;
	for (t in matchTrace.matches) {
		var m : new Mappings!Mapping;
		m.mappingsModel = mm;
		m.name = t.left.name + " and " + t.right.name;
		("left: " + t.left).println();
		m.left = t.left;
		("right: " + t.right).println();
		m.right = t.right;
		("matching: " + t.matching).println();
		m.matching = t.matching;
			
		if (t.`rule` <> null) {
			("rule: " + t.`rule`.name).println();
			m.mappingRule = t.`rule`.name;
		} else {
			"> No mapping rule for match trace...".println();
			m.mappingRule = "No mapping rule";
		}
			
		for (k in t.info.keySet()) {
			if (k <> null) {
				var e : new Mappings!StringToObjectEntry;
				e.key = k;
				e.value = t.info.get(k).asString();
				m.info.add(e);
			}
		}
		
		"".println();
	}
	"> Done.".println();
	"".println();
	
	cleanMappings(mm);
}

operation cleanMappings(mm : Mappings!MappingsModel) {
	"> Cleaning up mappings...".println();
	"".println();
	
	"> Pass 1/2...".println();
	"".println();
	
	var toRemove : Bag;
	for (m1 in mm.mappings) {
		if (m1.mappingRule == "No mapping rule") {
			toRemove.addAll(m1.asBag());
		} 
	}
	
	for (tr in toRemove) {
		mm.mappings.remove(tr);
	}
	toRemove.clear();
	
	"> Pass 2/2...".println();
	"".println();
	
	for (m1 in mm.mappings) {
		for (m2 in mm.mappings) {
			if (m1 <> m2) {
				if (m1.matching and not m2.matching and m1.mappingRule.matches(m2.mappingRule) and (m1.left == m2.left or m1.right == m2.right)) {
					toRemove.addAll(m2.asBag());
				} else {
					if (not m1.matching and m2.matching and m1.mappingRule.matches(m2.mappingRule) and (m1.left == m2.left or m1.right == m2.right)){
						toRemove.addAll(m1.asBag());
					}
				}
			}
		}
	}
	
	for (tr in toRemove) {
		mm.mappings.remove(tr);
	}
	
	"> Done.".println();
}
