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

operation String fuzzyMatch(other : String) : Boolean {
	var result = false;
	if (other <> null) {
		result = stringComparator.apply(self.toLowerCase(), other.toLowerCase()) > 0.8;
	}
	return result;
}

operation String fuzzyDistance(other : String) : Real {
	var distance;
	if (other <> null) {
		distance = stringComparator.apply(self.toLowerCase(), other.toLowerCase());
	} else {
		distance = 1.0;
	}
	return distance;
}

operation String dataTypeFuzzyMatch(other : String) : Boolean {
	var result = false;
	if (other <> null) {
		switch(self) {
			case "Integer" : result = other.matches("int8|uint8|int16|uint16|int32|uint32|single|Inherit|auto");
			case "Real" : result = other.matches("double|Inherit|auto");
			case "Boolean" : result = other.matches("boolean|Inherit|auto");
			default : result = (other.matches("Inherit|auto") or stringComparator.apply(self.toLowerCase(), other.toLowerCase()) > 0.8);
		}
	}
	return result;
}

operation Any matches(opposite : Any) : Boolean {
	var result;
	if (self.isTypeOf(String) and opposite.isTypeOf(String)) {
		result = self->matches(opposite);
	} else {
		if (self.isKindOf(Collection) and opposite.isKindOf(Collection)) {
			if (not self.isEmpty() and not opposite.isEmpty()) {
				result = self->matches(opposite);
			} else {
				result = true;
			}
		} else {
			result = self->matches(opposite);
		}
	}
	return result;
}
