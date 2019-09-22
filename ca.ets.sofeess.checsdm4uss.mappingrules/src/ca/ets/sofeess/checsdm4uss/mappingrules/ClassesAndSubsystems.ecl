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

// Mapping rules between UML classes (components included) and Simulink subsystem blocks

// Mapping rule: mr_0001a
rule MatchUMLComponentAndSimulinkModel
	match component : UML!Component
	with simulinkModel : Simulink!SimulinkModel
	{
		guard {
			var isRootSimulinkModel = simulinkModel.parent == null;
			
			return not isRootSimulinkModel;
		}
		compare {
			// Inputs
			var componentInputs = obtainInputs(component);
			var simulinkModelInputs = simulinkModel.ownedPorts.select(port | port.isTypeOf(Simulink!InPort)).asBag();
			
			// Outputs
			var componentOutputs = obtainOutputs(component);
			var simulinkModelOutputs = simulinkModel.ownedPorts.select(port | port.isTypeOf(Simulink!OutPort)).asBag();
			
			// Nested elements
			var nestedComponents = component.nestedClassifier.select(c | c.isTypeOf(UML!Component)).asBag();
			var nestedSubsystems = simulinkModel.subBlocks.select(b | (b.isTypeOf(Simulink!SubSystem) or b.isTypeOf(Simulink!SimulinkModel)) and not b.name.matches("ModelInfo")).asBag();
			
			// Comparison
			var nameDistance = component.name.fuzzyDistance(simulinkModel.name);
			var similarNames = component.name.fuzzyMatch(simulinkModel.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", component.name + " <> " + simulinkModel.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameInputs = componentInputs.matches(simulinkModelInputs);
			var inputs;
			if (not sameInputs) {
				inputs = "Distinct inputs";
				
				matchInfo.put("UML component inputs", componentInputs);
				matchInfo.put("Simulink model inputs", simulinkModelInputs);
			} else {
				inputs = "Same inputs";
			}
			matchInfo.put(inputs, sameInputs);
			var sameOutputs = componentOutputs.matches(simulinkModelOutputs);
			var outputs;
			if (not sameOutputs) {
				outputs = "Distinct outputs";
				
				matchInfo.put("UML component outputs", componentOutputs);
				matchInfo.put("Simulink model outputs", simulinkModelOutputs);
			} else {
				outputs = "Same outputs";
			}
			matchInfo.put(outputs, sameOutputs);
			var sameInternals = nestedComponents.matches(nestedSubsystems);
			var internals;
			if (not sameInternals) {
				internals = "Distinct internals";
				
				matchInfo.put("UML component nested components", nestedComponents);
				matchInfo.put("Simulink model nested subsystems", nestedSubsystems);
			} else {
				internals = "Same internals";
			}
			matchInfo.put(internals, sameInternals);
			
			return similarNames and sameInputs and sameOutputs and sameInternals;
		}
	}

// Mapping rule: mr_0001b
rule MatchUMLComponentAndSimulinkSubsystemBlock
	match component : UML!Component
	with subsystem : Simulink!SubSystem
	{
		guard {
			var isModelInfo = subsystem.name.matches("ModelInfo");
			
			var isNestedComponent = component.owner <> null;
			var isNestedSubsystem = subsystem.parent <> null;
			
			return not isModelInfo and ((isNestedComponent and isNestedSubsystem) or (not isNestedComponent and not isNestedSubsystem));
		}
		compare {
			var comparisonResult = true;
			if (component.owner <> null and subsystem.parent <> null) {
				var containerNameDistance = component.owner.name.fuzzyDistance(subsystem.parent.name);
				var similarContainerNames = component.owner.name.fuzzyMatch(subsystem.parent.name);
				var containerNames;
				if (not similarContainerNames) {
					containerNames = "Distinct containers";
					
					matchInfo.put("Container name distance", component.owner.name + " <> " + subsystem.parent.name);
				} else {
					containerNames = "Similar containers";
				}
				matchInfo.put(containerNames, similarContainerNames);
				comparisonResult = comparisonResult and similarContainerNames;
			}
			
			// Inputs
			var componentInputs = obtainInputs(component);
			var subsystemInputs = subsystem.ownedPorts.select(port | port.isTypeOf(Simulink!InPort)).sortBy(p | p.name).asBag();
			
			// Outputs
			var componentOutputs = obtainOutputs(component);
			var subsystemOutputs = subsystem.ownedPorts.select(port | port.isTypeOf(Simulink!OutPort)).sortBy(p | p.name).asBag();
			
			// Nested elements
			var nestedComponents = component.nestedClassifier.select(c | c.isTypeOf(UML!Component)).sortBy(c | c.name).asBag();
			var nestedSubsystems = subsystem.subBlocks.select(b | b.isTypeOf(Simulink!SubSystem) and not b.name.matches("ModelInfo")).sortBy(b | b.name).asBag();
			
			// Comparison
			var nameDistance = component.name.fuzzyDistance(subsystem.name);
			var similarNames = component.name.fuzzyMatch(subsystem.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", component.name + " <> " + subsystem.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameInputs = componentInputs.matches(subsystemInputs);
			var inputs;
			if (not sameInputs) {
				inputs = "Distinct inputs";
				
				matchInfo.put("UML component inputs", componentInputs);
				matchInfo.put("Simulink subsystem inputs", subsystemInputs);
			} else {
				inputs = "Same inputs";
			}
			matchInfo.put(inputs, sameInputs);
			var sameOutputs = componentOutputs.matches(subsystemOutputs);
			var outputs;
			if (not sameOutputs) {
				outputs = "Distinct outputs";
				
				matchInfo.put("UML component outputs", componentOutputs);
				matchInfo.put("Simulink subsystem outputs", subsystemOutputs);
			} else {
				outputs = "Same outputs";
			}
			matchInfo.put(outputs, sameOutputs);
			var sameInternals = nestedComponents.matches(nestedSubsystems);
			var internals;
			if (not sameInternals) {
				internals = "Distinct internals";
				
				matchInfo.put("UML component nested components", nestedComponents);
				matchInfo.put("Simulink subsystem nested subsystems", nestedSubsystems);
			} else {
				internals = "Same internals";
			}
			matchInfo.put(internals, sameInternals);
			
			return comparisonResult and similarNames and sameInputs and sameOutputs and sameInternals;
		}
	}

// Mapping rule: mr_0002
rule MatchUMLClassAndSimulinkSubsystemBlock
	match class : UML!Class
	with subsystem : Simulink!SubSystem
	{
		guard {
			var isDataDictionaryClass = class.namespace.name.equals("datadictionary");
			
			return not isDataDictionaryClass;
		}
		compare {
			// Inputs
			var classInputs = obtainInputs(class);
			var subsystemInputs = subsystem.ownedPorts.select(port | port.isTypeOf(Simulink!InPort)).asBag();
			
			// Outputs
			var classOutputs = obtainOutputs(class);
			var subsystemOutputs = subsystem.ownedPorts.select(port | port.isTypeOf(Simulink!OutPort)).asBag();
			
			// Comparison
			var nameDistance = class.name.fuzzyDistance(subsystem.name);
			var similarNames = class.name.fuzzyMatch(subsystem.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", class.name + " <> " + subsystem.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameInputs = classInputs.matches(subsystemInputs);
			var inputs;
			if (not sameInputs) {
				inputs = "Distinct inputs";
				
				matchInfo.put("UML class inputs", classInputs);
				matchInfo.put("Simulink subsystem inputs", subsystemInputs);
			} else {
				inputs = "Same inputs";
			}
			matchInfo.put(inputs, sameInputs);
			var sameOutputs = classOutputs.matches(subsystemOutputs);
			var outputs;
			if (not sameOutputs) {
				outputs = "Distinct outputs";
				
				matchInfo.put("UML class outputs", classOutputs);
				matchInfo.put("Simulink subsystem outputs", subsystemOutputs);
			} else {
				outputs = "Same outputs";
			}
			matchInfo.put(outputs, sameOutputs);
			
			return similarNames and sameInputs and sameOutputs;
		}
	}

// Mapping rule: mr_0003
rule MatchUMLInputParameterAndSimulinkBlockInput
	match inputParameter : UML!Parameter
	with blockInput : Simulink!InPort
	{
		guard {
			var isInputParameter = inputParameter.direction == UML!ParameterDirectionKind#`in`;
			var isSimulinkPortBlock = blockInput.block.isKindOf(Simulink!PortBlock);
			var isSimulinkReference = blockInput.block.isKindOf(Simulink!Reference);
			var isParentSimulinkBasicBlock = blockInput.block.isTypeOf(Simulink!Block);
			
			return isInputParameter and not isSimulinkPortBlock and not isSimulinkReference and not isParentSimulinkBasicBlock;
		}
		compare {
			var nameDistance = inputParameter.name.fuzzyDistance(blockInput.name);
			var similarNames = inputParameter.name.fuzzyMatch(blockInput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", inputParameter.name + " <> " + blockInput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = inputParameter.type.name.dataTypeFuzzyMatch(blockInput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", inputParameter.type.name);
				matchInfo.put("Simulink block input data type", blockInput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0004
rule MatchUMLOutputParameterAndSimulinkBlockInput
	match outputParameter : UML!Parameter
	with blockInput : Simulink!InPort
	{
		guard {
			var isOutputParameter = (outputParameter.direction == UML!ParameterDirectionKind#`return` or outputParameter.direction == UML!ParameterDirectionKind#out);
			var isSimulinkPortBlock = blockInput.block.isKindOf(Simulink!PortBlock);
			var isSimulinkReference = blockInput.block.isKindOf(Simulink!Reference);
			var isParentSimulinkBasicBlock = blockInput.block.isTypeOf(Simulink!Block);
			
			return isOutputParameter and not isSimulinkPortBlock and not isSimulinkReference and not isParentSimulinkBasicBlock;
		}
		compare {
			var nameDistance = outputParameter.name.fuzzyDistance(blockInput.name);
			var similarNames = outputParameter.name.fuzzyMatch(blockInput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", outputParameter.name + " <> " + blockInput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = outputParameter.type.name.dataTypeFuzzyMatch(blockInput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", outputParameter.type.name);
				matchInfo.put("Simulink block input data type", blockInput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0005
rule MatchUMLInputParameterAndSimulinkBlockOutput
	match inputParameter : UML!Parameter
	with blockOutput : Simulink!OutPort
	{
		guard {
			var isInputParameter = inputParameter.direction == UML!ParameterDirectionKind#`in`;
			var isSimulinkPortBlock = blockOutput.block.isKindOf(Simulink!PortBlock);
			var isSimulinkReference = blockOutput.block.isKindOf(Simulink!Reference);
			var isParentSimulinkBasicBlock = blockOutput.block.isTypeOf(Simulink!Block);
			
			return isInputParameter and not isSimulinkPortBlock and not isSimulinkReference and not isParentSimulinkBasicBlock;
		}
		compare {
			var nameDistance = inputParameter.name.fuzzyDistance(blockOutput.name);
			var similarNames = inputParameter.name.fuzzyMatch(blockOutput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", inputParameter.name + " <> " + blockOutput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = inputParameter.type.name.dataTypeFuzzyMatch(blockOutput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", inputParameter.type.name);
				matchInfo.put("Simulink block output data type", blockOutput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0006
rule MatchUMLOutputParameterAndSimulinkBlockOutput
	match outputParameter : UML!Parameter
	with blockOutput : Simulink!OutPort
	{
		guard {
			var isOutputParameter = (outputParameter.direction == UML!ParameterDirectionKind#`return` or outputParameter.direction == UML!ParameterDirectionKind#out);
			var isSimulinkPortBlock = blockOutput.block.isKindOf(Simulink!PortBlock);
			var isSimulinkReference = blockOutput.block.isKindOf(Simulink!Reference);
			var isParentSimulinkBasicBlock = blockOutput.block.isTypeOf(Simulink!Block);
			
			return isOutputParameter and not isSimulinkPortBlock and not isSimulinkReference and not isParentSimulinkBasicBlock;
		}
		compare {
			var nameDistance = outputParameter.name.fuzzyDistance(blockOutput.name);
			var similarNames = outputParameter.name.fuzzyMatch(blockOutput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", outputParameter.name + " <> " + blockOutput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = outputParameter.type.name.dataTypeFuzzyMatch(blockOutput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", outputParameter.type.name);
				matchInfo.put("Simulink block output data type", blockOutput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0007
rule MatchUMLClassAndStateflowChart
	match class : UML!Class
	with chart : Simulink!Chart 
	{
		compare {
			// Inputs
			var classInputs = obtainInputs(class);
			var chartInputs = chart.ownedPorts.select(port | port.isTypeOf(Simulink!InputData)).sortBy(p | p.name).asBag();
			
			// Outputs
			var classOutputs = obtainOutputs(class);
			var chartOutputs = chart.ownedPorts.select(port | port.isTypeOf(Simulink!OutputData)).sortBy(p | p.name).asBag();
			
			// Comparison
			var nameDistance = class.name.fuzzyDistance(chart.name);
			var similarNames = class.name.fuzzyMatch(chart.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", class.name + " <> " + chart.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			
			var sameInputs = classInputs.matches(chartInputs);
			var inputs;
			if (not sameInputs) {
				inputs = "Distinct inputs";
				
				matchInfo.put("UML class inputs", classInputs);
				matchInfo.put("Stateflow chart inputs", chartInputs);
			} else {
				inputs = "Same inputs";
			}
			matchInfo.put(inputs, sameInputs);
			var sameOutputs = classOutputs.matches(chartOutputs);
			var outputs;
			if (not sameOutputs) {
				outputs = "Distinct outputs";
				
				matchInfo.put("UML class outputs", classOutputs);
				matchInfo.put("Stateflow chart outputs", chartOutputs);
			} else {
				outputs = "Same outputs";
			}
			matchInfo.put(outputs, sameOutputs);
			
			return similarNames and sameInputs and sameOutputs;
		}
	}

// Mapping rule: mr_0008
rule MatchUMLInputParameterAndStateflowChartInput
	match inputParameter : UML!Parameter
	with chartInput : Simulink!InputData
	{
		guard {
			var isInputParameter = inputParameter.direction == UML!ParameterDirectionKind#`in`;
			
			return isInputParameter;
		}
		compare {
			var nameDistance = inputParameter.name.fuzzyDistance(chartInput.name);
			var similarNames = inputParameter.name.fuzzyMatch(chartInput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", inputParameter.name + " <> " + chartInput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = inputParameter.type.name.dataTypeFuzzyMatch(chartInput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", inputParameter.type.name);
				matchInfo.put("Stateflow chart input data type", chartInput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0009
rule MatchUMLOutputParameterAndStateflowChartInput
	match outputParameter : UML!Parameter
	with chartInput : Simulink!InputData
	{
		guard {
			var isOutputParameter = outputParameter.direction == UML!ParameterDirectionKind#`return` or outputParameter.direction == UML!ParameterDirectionKind#out;
			
			return isOutputParameter;
		}
		compare {
			var nameDistance = outputParameter.name.fuzzyDistance(chartInput.name);
			var similarNames = outputParameter.name.fuzzyMatch(chartInput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", outputParameter.name + " <> " + chartInput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = outputParameter.type.name.dataTypeFuzzyMatch(chartInput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", outputParameter.type.name);
				matchInfo.put("Stateflow chart input data type", chartInput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0010
rule MatchUMLInputParameterAndStateflowChartOutput
	match inputParameter : UML!Parameter
	with chartOutput : Simulink!OutputData
	{
		guard {
			var isInputParameter = inputParameter.direction = UML!ParameterDirectionKind#`in`;
			
			return isInputParameter;
		}
		compare {
			var nameDistance = inputParameter.name.fuzzyDistance(chartOutput.name);
			var similarNames = inputParameter.name.fuzzyMatch(chartOutput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", inputParameter.name + " <> " + chartOutput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = inputParameter.type.name.dataTypeFuzzyMatch(chartOutput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", inputParameter.type.name);
				matchInfo.put("Stateflow chart output data type", chartOutput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

// Mapping rule: mr_0011
rule MatchUMLOutputParameterAndStateflowChartOutput
	match outputParameter : UML!Parameter
	with chartOutput : Simulink!OutputData
	{
		guard {
			var isOutputParameter = outputParameter.direction == UML!ParameterDirectionKind#`return` or outputParameter.direction == UML!ParameterDirectionKind#out;
			
			return isOutputParameter;
		}
		compare {
			var nameDistance = outputParameter.name.fuzzyDistance(chartOutput.name);
			var similarNames = outputParameter.name.fuzzyMatch(chartOutput.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", outputParameter.name + " <> " + chartOutput.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var similarTypeNames = outputParameter.type.name.dataTypeFuzzyMatch(chartOutput.dataType);
			var typeNames;
			if (not similarTypeNames) {
				typeNames = "Distinct type names";
				
				matchInfo.put("UML parameter data type", outputParameter.type.name);
				matchInfo.put("Simulink block output data type", chartOutput.dataType);
			} else {
				typeNames = "Similar type names";
			}
			matchInfo.put(typeNames, similarTypeNames);
			
			return similarNames and similarTypeNames;
		}
	}

operation obtainInputs(class : UML!Class) : Bag {
	var classInputs : Bag;
	if (class.clientDependency <> null) {
		for (realizations in class.clientDependency.select(dependency | dependency.isTypeOf(UML!InterfaceRealization))) {
			for (realization in realizations) {
				for (interface in realization.supplier) {
					for (`operation` in interface.ownedOperation) {
						classInputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`in`));
					}
				}
			}
		}
		for (usages in class.clientDependency.select(dependency | dependency.isTypeOf(UML!Usage))) {
			for (usage in usages) {
				for (interface in usage.supplier) {
					for (`operation` in interface.ownedOperation) {
						classInputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`return` or parameter.direction = UML!ParameterDirectionKind#out));
					}
				}
			}
		}
	}
	if (class.ownedPort <> null) {
		for (port in class.ownedPort) {
			for (interface in port.provided) {
				for (`operation` in interface.ownedOperation) {
					var i : Integer = 0;
					while (i < port.lower) {
						classInputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`in`));
						i = i + 1;
					}
				}
			}
			for (interface in port.required) {
				for (`operation` in interface.ownedOperation) {
					var i : Integer = 0;
					while (i < port.lower) {
						classInputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`return` or parameter.direction = UML!ParameterDirectionKind#out));
						i = i + 1;
					}
				}
			}
		}
	}
	return classInputs.sortBy(p | p.name).asBag();
}

operation obtainOutputs(class : UML!Class) : Bag {
	var classOutputs : Bag;
	if (class.clientDependency <> null) {
		for (realizations in class.clientDependency.select(dependency | dependency.isTypeOf(UML!InterfaceRealization))) {
			for (realization in realizations) {
				for (interface in realization.supplier) {
					for (`operation` in interface.ownedOperation) {
						classOutputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`return` or parameter.direction = UML!ParameterDirectionKind#out));
					}
				}
			}
		}
		for (usages in class.clientDependency.select(dependency | dependency.isTypeOf(UML!Usage))) {
			for (usage in usages) {
				for (interface in usage.supplier) {
					for (`operation` in interface.ownedOperation) {
						classOutputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`in`));
					}
				}
			}
		}
	}
	if (class.ownedPort <> null) {
		for (port in class.ownedPort) {
			for (interface in port.provided) {
				for (`operation` in interface.ownedOperation) {
					var i : Integer = 0;
					while (i < port.lower) {
						classOutputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`return` or parameter.direction = UML!ParameterDirectionKind#out));
						i = i + 1;
					}
				}
			}
			for (interface in port.required) {
				for (`operation` in interface.ownedOperation) {
					var i : Integer = 0;
					while (i < port.lower) {
						classOutputs.addAll(`operation`.ownedParameter.select(parameter | parameter.direction = UML!ParameterDirectionKind#`in`));
						i = i + 1;
					}
				}
			}
		}
	}
	return classOutputs.sortBy(p | p.name).asBag();
}
