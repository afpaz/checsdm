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

// Mapping rules between UML state machines and Stateflow charts

// Mapping rule: mr_0012
rule MatchUMLStateMachineAndStateflowChart
	match stateMachine : UML!StateMachine
	with chart : Simulink!Chart 
	{
		//guard: chart.decomposition = Simulink!DecompositionType#PARALLEL_AND
		compare {
			var stateMachineRegions = stateMachine.region.asBag();
			var chartStates = chart.children.select(c | c.isTypeOf(Simulink!State)).asBag();
			
			var nameDistance = stateMachine.name.fuzzyDistance(chart.name);
			var similarNames = stateMachine.name.fuzzyMatch(chart.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", stateMachine.name + " <> " + chart.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			
			var comparisonResult;
			if (stateMachineRegions.size() > 1) {
				var sameRegions = stateMachineRegions.matches(chartStates);
				var regions;
				if (not sameRegions) {
					regions = "Distinct regions";
					
					matchInfo.put("UML state machine regions", stateMachineRegions);
					matchInfo.put("Stateflow chart regions", chartStates);
				} else {
					regions = "Same regions";
				}
				matchInfo.put(regions, sameRegions);
				
				comparisonResult = similarNames and sameRegions;
			} else {
				var stateMachineVertexes = stateMachine.region.subvertex.select(v | not (v.isTypeOf(UML!FinalState) or (v.isTypeOf(UML!Pseudostate) and v.kind = UML!PseudostateKind#initial))).asBag();
				var chartVertexes = chart.children.select(c | c.isKindOf(Simulink!Vertex)).asBag();
				
				var stateMachineTransitions = stateMachine.region.transition.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
				var chartTransitions = chart.children.select(c | c.isTypeOf(Simulink!Transition)).asBag();
				
				var sameVertexes = stateMachineVertexes.matches(chartVertexes);
				var vertexes;
				if (not sameVertexes) {
					vertexes = "Distinct vertexes";
					
					matchInfo.put("UML state machine vertexes", stateMachineVertexes);
					matchInfo.put("Stateflow chart vertexes", chartVertexes);
				} else {
					vertexes = "Same vertexes";
				}
				matchInfo.put(vertexes, sameVertexes);
				var sameTransitions = stateMachineTransitions.matches(chartTransitions);
				var transitions;
				if (not sameTransitions) {
					transitions = "Distinct transitions";
					
					matchInfo.put("UML state machine transitions", stateMachineTransitions);
					matchInfo.put("Stateflow chart transitions", chartTransitions);
				} else {
					transitions = "Same transitions";
				}
				matchInfo.put(transitions, sameTransitions);
				
				comparisonResult = similarNames and sameVertexes and sameTransitions;
			}
			
			return comparisonResult;
		} 
	}

// Mapping rule: mr_0013
rule MatchUMLRegionAndStateflowParallelState
	match region : UML!Region
	with state : Simulink!State
	{
		guard {
			var stateflowParallelState = state.parent.decomposition = Simulink!DecompositionType#PARALLEL_AND;
			var stateflowCompositeState = not state.children.isEmpty();
			
			return stateflowParallelState and stateflowCompositeState;
		}
		compare {
			var containerNameDistance = region.owner.name.fuzzyDistance(state.parent.name);
			var similarContainerNames = region.owner.name.fuzzyMatch(state.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", region.owner.name + " <> " + state.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var regionVertexes = region.subvertex.select(v | not (v.isTypeOf(UML!FinalState) or (v.isTypeOf(UML!Pseudostate) and v.kind = UML!PseudostateKind#initial))).asBag();
			var stateVertexes = state.children.select(c | c.isKindOf(Simulink!Vertex)).asBag();
			
			var regionTransitions = region.transition.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
			var stateTransitions = state.children.select(c | c.isTypeOf(Simulink!Transition)).asBag();
			
			var nameDistance = region.name.fuzzyDistance(state.name);
			var similarNames = region.name.fuzzyMatch(state.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", region.name + " <> " + state.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameVertexes = regionVertexes.matches(stateVertexes);
			var vertexes;
			if (not sameVertexes) {
				vertexes = "Distinct vertexes";
				
				matchInfo.put("UML region vertexes", regionVertexes);
				matchInfo.put("Stateflow state subvertexes", stateVertexes);
			} else {
				vertexes = "Same vertexes";
			}
			matchInfo.put(vertexes, sameVertexes);
			var sameTransitions = regionTransitions.matches(stateTransitions);
			var transitions;
			if (not sameTransitions) {
				vertexes = "Distinct transitions";
				
				matchInfo.put("UML region transitions", regionTransitions);
				matchInfo.put("Stateflow state inner transitions", stateTransitions);
			} else {
				vertexes = "Same transitions";
			}
			matchInfo.put(transitions, sameTransitions);
			
			return similarContainerNames and similarNames and sameVertexes and sameTransitions;
		}
	}

// Mapping rule: mr_0014
rule MatchUMLCompositeStateAndStateflowCompositeState
	match umlState : UML!State
	with sfwState : Simulink!State
	{
		guard {
			var umlCompositeState = umlState.isComposite;
			var stateflowCompositeState = not sfwState.children.isEmpty();
			var stateflowExclusiveState = sfwState.decomposition = Simulink!DecompositionType#EXCLUSIVE_OR;
			var stateflowExclusiveParent = sfwState.parent.decomposition = Simulink!DecompositionType#EXCLUSIVE_OR;
			
			return umlCompositeState and stateflowCompositeState and stateflowExclusiveState and stateflowExclusiveParent;
		}
		compare {
			var containerNameDistance = umlState.owner.name.fuzzyDistance(sfwState.parent.name);
			var similarContainerNames = umlState.owner.name.fuzzyMatch(sfwState.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", umlState.owner.name + " <> " + sfwState.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var umlStateInitialTransitions = umlState.incoming.select(t | t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`).asBag();
			var sfwStateInitialTransitions = sfwState.incomingTransitions.select(t | t.isDefaultTransition or t.source == null).asBag();
			
			var umlStateIncomingTransitions = umlState.incoming.select(t | not (t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`)).asBag();
			var sfwStateIncomingTransitions = sfwState.incomingTransitions.select(t | not t.isDefaultTransition and t.source <> null).asBag();
			
			var umlStateOutgoingTransitions = umlState.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
			var sfwStateOutgoingTransitions = sfwState.outgoingTransitions.asBag();
			
			var umlStateRegions = umlState.region.asBag();
			var sfwStateStates = sfwState.children.select(c | c.isTypeOf(Simulink!State)).asBag();
			
			var comparisonResult;
			
			var nameDistance = umlState.name.fuzzyDistance(sfwState.name);
			var similarNames = umlState.name.fuzzyMatch(sfwState.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", umlState.name + " <> " + sfwState.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			comparisonResult = similarContainerNames and similarNames;
			
			if (not umlStateInitialTransitions.isEmpty() and not sfwStateInitialTransitions.isEmpty()) {
				var sameDefaultTransitions = umlStateInitialTransitions.matches(sfwStateInitialTransitions);
				var defaultTransitions;
				if (not sameDefaultTransitions) {
					defaultTransitions = "Distinct default transitions";
					
					matchInfo.put("UML initial transition", umlStateInitialTransitions);
					matchInfo.put("Stateflow default transition", sfwStateInitialTransitions);
				} else {
					defaultTransitions = "Same default transitions";
				}
				matchInfo.put(defaultTransitions, sameDefaultTransitions);
				comparisonResult = comparisonResult and sameDefaultTransitions;
			} else {
				var sameIncomingTransitions = umlStateIncomingTransitions.matches(sfwStateIncomingTransitions);
				var incomingTransitions;
				if (not sameIncomingTransitions) {
					incomingTransitions = "Distinct incoming transitions";
					
					matchInfo.put("UML incoming transitions", umlStateIncomingTransitions);
					matchInfo.put("Stateflow incoming transitions", sfwStateIncomingTransitions);
				} else {
					incomingTransitions = "Same incoming transitions";
				}
				matchInfo.put(incomingTransitions, sameIncomingTransitions);
				comparisonResult = comparisonResult and sameIncomingTransitions;
			}
			
			var sameOutgoingTransitions = umlStateOutgoingTransitions.matches(sfwStateOutgoingTransitions);
			var outgoingTransitions;
			if (not sameOutgoingTransitions) {
				outgoingTransitions = "Distinct outgoing transitions";
				
				matchInfo.put("UML outgoing transitions", umlStateOutgoingTransitions);
				matchInfo.put("Stateflow outgoing transitions", sfwStateOutgoingTransitions);
			} else {
				outgoingTransitions = "Same outgoing transitions";
			}
			matchInfo.put(outgoingTransitions, sameOutgoingTransitions);
			comparisonResult = comparisonResult and sameOutgoingTransitions;
			
			if (umlStateRegions.size() > 1) {
				var sameRegions = umlStateRegions.matches(sfwStateStates);
				var regions;
				if (not sameRegions) {
					regions = "Distinct regions";
					
					matchInfo.put("UML state regions", umlStateRegions);
					matchInfo.put("Stateflow state regions", sfwStateStates);
				} else {
					regions = "Same regions";
				}
				matchInfo.put(regions, sameRegions);
				
				comparisonResult = comparisonResult and sameRegions;
			} else {
				var umlCompositeStateVertexes = umlState.region.subvertex.select(v | not (v.isTypeOf(UML!FinalState) or (v.isTypeOf(UML!Pseudostate) and v.kind = UML!PseudostateKind#initial))).asBag();
				var sfwCompositeStateVertexes = sfwState.children.select(c | c.isKindOf(Simulink!Vertex)).asBag();
				
				var umlCompositeStateTransitions = umlState.region.transition.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
				var sfwCompositeStateTransitions = sfwState.children.select(c | c.isTypeOf(Simulink!Transition)).asBag();
				
				var sameVertexes = umlCompositeStateVertexes.matches(sfwCompositeStateVertexes);
				var vertexes;
				if (not sameVertexes) {
					vertexes = "Distinct vertexes";
					
					matchInfo.put("UML state subvertexes", umlCompositeStateVertexes);
					matchInfo.put("Stateflow state subvertexes", sfwCompositeStateVertexes);
				} else {
					vertexes = "Same vertexes";
				}
				matchInfo.put(vertexes, sameVertexes);
				var sameTransitions = umlCompositeStateTransitions.matches(sfwCompositeStateTransitions);
				var transitions;
				if (not sameTransitions) {
					vertexes = "Distinct transitions";
					
					matchInfo.put("UML state inner transitions", umlCompositeStateTransitions);
					matchInfo.put("Stateflow state inner transitions", sfwCompositeStateTransitions);
				} else {
					vertexes = "Same transitions";
				}
				matchInfo.put(transitions, sameTransitions);
				
				comparisonResult = comparisonResult and sameVertexes and sameTransitions;
			}
			return comparisonResult;
		}
	}

// Mapping rule: mr_0015
rule MatchUMLStateAndStateflowState
	match umlState : UML!State
	with sfwState : Simulink!State
	{
		guard {
			var umlCompositeState = umlState.isComposite;
			var umlFinalState = umlState.isTypeOf(UML!FinalState);
			var sfwCompositeState = not sfwState.children.isEmpty();
			var sfwOrState = sfwState.decomposition = Simulink!DecompositionType#EXCLUSIVE_OR and sfwState.parent.decomposition = Simulink!DecompositionType#EXCLUSIVE_OR;
			
			var similarNames = umlState.name.fuzzyMatch(sfwState.name);
			
			var umlStateInitialTransitions = umlState.incoming.select(t | t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`).asBag();
			var sfwStateInitialTransitions = sfwState.incomingTransitions.select(t | t.isDefaultTransition or t.source == null).asBag();
			
			var umlStateIncomingTransitions = umlState.incoming.select(t | not (t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`)).asBag();
			var sfwStateIncomingTransitions = sfwState.incomingTransitions.select(t | not t.isDefaultTransition and t.source <> null).asBag();
			
			var umlStateOutgoingTransitions = umlState.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
			var sfwStateOutgoingTransitions = sfwState.outgoingTransitions.asBag();
			
			var sameDefaultTransitions = false;
			var sameIncomingTransitions = false;
			if (not umlStateInitialTransitions.isEmpty() and not sfwStateInitialTransitions.isEmpty()) {
				sameDefaultTransitions = umlStateInitialTransitions.matches(sfwStateInitialTransitions);
			} else {
				sameIncomingTransitions = umlStateIncomingTransitions.matches(sfwStateIncomingTransitions);
			}
			var sameOutgoingTransitions = umlStateOutgoingTransitions.matches(sfwStateOutgoingTransitions);
			
			return not umlCompositeState and not umlFinalState and not sfwCompositeState and sfwOrState and (similarNames or sameDefaultTransitions or sameIncomingTransitions or sameOutgoingTransitions);
		}
		compare {
			var containerNameDistance = umlState.owner.name.fuzzyDistance(sfwState.parent.name);
			var similarContainerNames = umlState.owner.name.fuzzyMatch(sfwState.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", umlState.owner.name + " <> " + sfwState.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var umlStateInitialTransitions = umlState.incoming.select(t | t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`).sortBy(t | t.name).asBag();
			var sfwStateInitialTransitions = sfwState.incomingTransitions.select(t | t.isDefaultTransition or t.source == null).sortBy(t | t.name).asBag();
			
			var umlStateIncomingTransitions = umlState.incoming.select(t | not (t.source.isTypeOf(UML!Pseudostate) and t.source.kind = UML!PseudostateKind#`initial`)).sortBy(t | t.name).asBag();
			var sfwStateIncomingTransitions = sfwState.incomingTransitions.select(t | not t.isDefaultTransition and t.source <> null).sortBy(t | t.name).asBag();
			
			var umlStateOutgoingTransitions = umlState.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).sortBy(t | t.name).asBag();
			var sfwStateOutgoingTransitions = sfwState.outgoingTransitions.sortBy(t | t.name).asBag();
			
			var comparisonResult;
			
			var nameDistance = umlState.name.fuzzyDistance(sfwState.name);
			var similarNames = umlState.name.fuzzyMatch(sfwState.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", umlState.name + " <> " + sfwState.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			comparisonResult = similarContainerNames and similarNames;
			
			if (not umlStateInitialTransitions.isEmpty() and not sfwStateInitialTransitions.isEmpty()) {
				var sameDefaultTransitions = umlStateInitialTransitions.matches(sfwStateInitialTransitions);
				var defaultTransitions;
				if (not sameDefaultTransitions) {
				defaultTransitions = "Distinct default transitions";
				
				matchInfo.put("UML initial transition", umlStateInitialTransitions);
				matchInfo.put("Stateflow default transition", sfwStateInitialTransitions);
				} else {
				defaultTransitions = "Same default transitions";
				}
				matchInfo.put(defaultTransitions, sameDefaultTransitions);
				comparisonResult = comparisonResult and sameDefaultTransitions;
			} else {
				var sameIncomingTransitions = umlStateIncomingTransitions.matches(sfwStateIncomingTransitions);
				var incomingTransitions;
				if (not sameIncomingTransitions) {
					incomingTransitions = "Distinct incoming transitions";
					
					matchInfo.put("UML incoming transitions", umlStateIncomingTransitions);
					matchInfo.put("Stateflow incoming transitions", sfwStateIncomingTransitions);
				} else {
					incomingTransitions = "Same incoming transitions";
				}
				matchInfo.put(incomingTransitions, sameIncomingTransitions);
				comparisonResult = comparisonResult and sameIncomingTransitions;
			}
			var sameOutgoingTransitions = umlStateOutgoingTransitions.matches(sfwStateOutgoingTransitions);
			var outgoingTransitions;
			if (not sameOutgoingTransitions) {
				outgoingTransitions = "Distinct outgoing transitions";
				
				matchInfo.put("UML outgoing transitions", umlStateOutgoingTransitions);
				matchInfo.put("Stateflow outgoing transitions", sfwStateOutgoingTransitions);
			} else {
				outgoingTransitions = "Same outgoing transitions";
			}
			matchInfo.put(outgoingTransitions, sameOutgoingTransitions);
			comparisonResult = comparisonResult and sameOutgoingTransitions;
			
			return comparisonResult;
		}
	}

// Mapping rule: mr_0016
rule MatchUMLChoicePseudostateAndStateflowConnectiveJunction
	match pseudostate : UML!Pseudostate
	with junction : Simulink!Junction
	{
		guard {
			var umlChoicePseudostate = pseudostate.kind == UML!PseudostateKind#choice;
			var sfwChoiceJunction = junction.outgoingTransitions.size() >= 2;
			
			var pseudostateIncomingTransitions = pseudostate.incoming.sortBy(t | t.name).asBag();
			var junctionIncomingTransitions = junction.incomingTransitions.sortBy(t | t.name).asBag();
			var sameIncomingTransitions = pseudostateIncomingTransitions.matches(junctionIncomingTransitions);
			
			var pseudostateOutgoingTransitions = pseudostate.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).sortBy(t | t.name).asBag();
			var junctionOutgoingTransitions = junction.outgoingTransitions.sortBy(t | t.name).asBag();
			var sameOutgoingTransitions = pseudostateOutgoingTransitions.matches(junctionOutgoingTransitions);
			
			return umlChoicePseudostate and sfwChoiceJunction and (sameIncomingTransitions or sameOutgoingTransitions);
		}
		compare {
			var containerNameDistance = pseudostate.owner.name.fuzzyDistance(junction.parent.name);
			var similarContainerNames = pseudostate.owner.name.fuzzyMatch(junction.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", pseudostate.owner.name + " <> " + junction.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var pseudostateIncomingTransitions = pseudostate.incoming.sortBy(t | t.name).asBag();
			var junctionIncomingTransitions = junction.incomingTransitions.sortBy(t | t.name).asBag();
			
			var pseudostateOutgoingTransitions = pseudostate.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).sortBy(t | t.name).asBag();
			var junctionOutgoingTransitions = junction.outgoingTransitions.sortBy(t | t.name).asBag();
			
			var sameIncomingTransitions = pseudostateIncomingTransitions.matches(junctionIncomingTransitions);
			var incomingTransitions;
			if (not sameIncomingTransitions) {
				incomingTransitions = "Distinct incoming transitions";
				
				matchInfo.put("UML incoming transitions", pseudostateIncomingTransitions);
				matchInfo.put("Stateflow incoming transitions", junctionIncomingTransitions);
			} else {
				incomingTransitions = "Same incoming transitions";
			}
			matchInfo.put(incomingTransitions, sameIncomingTransitions);
			
			var sameOutgoingTransitions = pseudostateOutgoingTransitions.matches(junctionOutgoingTransitions);
			var outgoingTransitions;
			if (not sameOutgoingTransitions) {
				outgoingTransitions = "Distinct outgoing transitions";
				
				matchInfo.put("UML outgoing transitions", pseudostateOutgoingTransitions);
				matchInfo.put("Stateflow outgoing transitions", junctionOutgoingTransitions);
			} else {
				outgoingTransitions = "Same outgoing transitions";
			}
			matchInfo.put(outgoingTransitions, sameOutgoingTransitions);
			
			return similarContainerNames and sameIncomingTransitions and sameOutgoingTransitions;
		}
	}

// Mapping rule: mr_0017
rule MatchUMLForkPseudostateAndStateflowCompositeState
	match pseudostate : UML!Pseudostate
	with state : Simulink!State
	{
		guard {
			var umlFork = pseudostate.kind = UML!PseudostateKind#fork;
			var stateflowCompositeState = not state.children.isEmpty();
			var stateflowParallelDecomposition = state.decomposition = Simulink!DecompositionType#PARALLEL_AND;
			
			return umlFork and stateflowCompositeState and stateflowParallelDecomposition;
		}
		compare {
			var pseudostateIncomingTransitions = pseudostate.incoming.asBag();
			var stateIncomingTransitions = state.incomingTransitions.asBag();
			
			var nameDistance = pseudostate.name.fuzzyDistance(state.name);
			var similarNames = pseudostate.name.fuzzyMatch(state.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", pseudostate.name + " <> " + state.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameIncomingTransitions = pseudostateIncomingTransitions.matches(stateIncomingTransitions);
			var incomingTransitions;
			if (not sameIncomingTransitions) {
				incomingTransitions = "Distinct incoming transitions";
				
				matchInfo.put("UML incoming transitions", pseudostateIncomingTransitions);
				matchInfo.put("Stateflow incoming transitions", stateIncomingTransitions);
			} else {
				incomingTransitions = "Same incoming transitions";
			}
			matchInfo.put(incomingTransitions, sameIncomingTransitions);
			
			return similarNames and sameIncomingTransitions;
		}
	}

// Mapping rule: mr_0018
rule MatchUMLJoinPseudostateAndStateflowCompositeState
	match pseudostate : UML!Pseudostate
	with state : Simulink!State
	{
		guard {
			var umlJoin = pseudostate.kind = UML!PseudostateKind#join;
			var stateflowCompositeState = not state.children.isEmpty();
			var stateflowParallelDecomposition = state.decomposition = Simulink!DecompositionType#PARALLEL_AND;
			
			return umlJoin and stateflowCompositeState and stateflowParallelDecomposition;
		}
		compare {
			var pseudostateOutgoingTransitions = pseudostate.outgoing.select(t | not t.target.isTypeOf(UML!FinalState)).asBag();
			var stateOutgoingTransitions = state.outgoingTransitions.asBag();
			
			var nameDistance = pseudostate.name.fuzzyDistance(state.name);
			var similarNames = pseudostate.name.fuzzyMatch(state.name);
			var names;
			if (not similarNames) {
				names = "Distinct names";
				
				matchInfo.put("Name distance", pseudostate.name + " <> " + state.name);
			} else {
				names = "Similar names";
			}
			matchInfo.put(names, similarNames);
			var sameOutgoingTransitions = pseudostateOutgoingTransitions.matches(stateOutgoingTransitions);
			var outgoingTransitions;
			if (not sameOutgoingTransitions) {
				outgoingTransitions = "Distinct outgoing transitions";
				
				matchInfo.put("UML outgoing transitions", pseudostateOutgoingTransitions);
				matchInfo.put("Stateflow outgoing transitions", stateOutgoingTransitions);
			} else {
				outgoingTransitions = "Same outgoing transitions";
			}
			matchInfo.put(outgoingTransitions, sameOutgoingTransitions);
			
			return similarNames and sameOutgoingTransitions;
		}
	}

// Mapping rule: mr_0019
rule MatchUMLDefaultTransitionAndStateflowDefaultTransition
	match umlTransition : UML!Transition
	with sfwTransition : Simulink!Transition
	{
		guard {
			var umlInitialPseudostate = umlTransition.source.isTypeOf(UML!Pseudostate) and umlTransition.source.kind = UML!PseudostateKind#initial;
			var sfwDefaultTransition = sfwTransition.isDefaultTransition and sfwTransition.source == null;
			
			var similarTargetNames = false;
			if (umlTransition.target <> null and sfwTransition.destination <> null) {
				similarTargetNames = umlTransition.target.name.fuzzyMatch(sfwTransition.destination.name);
			}
			
			return umlInitialPseudostate and sfwDefaultTransition;
		}
		compare {
			var containerNameDistance = umlTransition.owner.name.fuzzyDistance(sfwTransition.parent.name);
			var similarContainerNames = umlTransition.owner.name.fuzzyMatch(sfwTransition.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", umlTransition.owner.name + " <> " + sfwTransition.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var targetNameDistance = umlTransition.target.name.fuzzyDistance(sfwTransition.destination.name);
			var similarTargetNames = umlTransition.target.name.fuzzyMatch(sfwTransition.destination.name);
			var targetNames;
			if (not similarTargetNames) {
				targetNames = "Distinct target";
				
				matchInfo.put("Target name distance", umlTransition.target.name + " <> " + sfwTransition.destination.name);
			} else {
				targetNames = "Similar target";
			}
			matchInfo.put(targetNames, similarTargetNames);
			
			return similarContainerNames and similarTargetNames;
		} 
	}

// Mapping rule: mr_0020
rule MatchUMLTransitionAndStateflowTransition
	match umlTransition : UML!Transition
	with sfwTransition : Simulink!Transition
	{
		guard {
			var umlInitialPseudostate = umlTransition.source.isTypeOf(UML!Pseudostate) and umlTransition.source.kind = UML!PseudostateKind#initial;
			var sfwDefaultTransition = sfwTransition.isDefaultTransition and sfwTransition.source == null;
			
			var similarSourceNames = false;
			var choiceSources = false;
			var similarTargetNames = false;
			var choiceTargets = false;
			if (umlTransition.source <> null and sfwTransition.source <> null and umlTransition.target <> null and sfwTransition.destination <> null) {
				similarSourceNames = umlTransition.source.name.fuzzyMatch(sfwTransition.source.name);
				choiceSources = umlTransition.source.isTypeOf(UML!Pseudostate) and umlTransition.source.kind = UML!PseudostateKind#choice and sfwTransition.source.isTypeOf(Simulink!Junction) and sfwTransition.source.outgoingTransitions.size() >= 2;
				similarTargetNames = umlTransition.target.name.fuzzyMatch(sfwTransition.destination.name);
				choiceTargets = umlTransition.target.isTypeOf(UML!Pseudostate) and umlTransition.target.kind = UML!PseudostateKind#choice and sfwTransition.destination.isTypeOf(Simulink!Junction) and sfwTransition.destination.outgoingTransitions.size() >= 2;
			}
			
			return not umlInitialPseudostate and not sfwDefaultTransition and (similarSourceNames or choiceSources or similarTargetNames or choiceTargets);
		}
		compare {
			var containerNameDistance = umlTransition.owner.name.fuzzyDistance(sfwTransition.parent.name);
			var similarContainerNames = umlTransition.owner.name.fuzzyMatch(sfwTransition.parent.name);
			var containerNames;
			if (not similarContainerNames) {
				containerNames = "Distinct containers";
				
				matchInfo.put("Container name distance", umlTransition.owner.name + " <> " + sfwTransition.parent.name);
			} else {
				containerNames = "Similar containers";
			}
			matchInfo.put(containerNames, similarContainerNames);
			
			var sourceNameDistance = umlTransition.source.name.fuzzyDistance(sfwTransition.source.name);
			var similarSourceNames = umlTransition.source.name.fuzzyMatch(sfwTransition.source.name);
			var choiceSources = umlTransition.source.isTypeOf(UML!Pseudostate) and umlTransition.source.kind = UML!PseudostateKind#choice and sfwTransition.source.isTypeOf(Simulink!Junction) and sfwTransition.source.outgoingTransitions.size() >= 2;
			var sourceNames;
			if (not similarSourceNames and not choiceSources) {
				sourceNames = "Distinct source";
				
				matchInfo.put("Source name distance", umlTransition.source.name + " <> " + sfwTransition.source.name);
			} else {
				sourceNames = "Similar source";
			}
			matchInfo.put(sourceNames, similarSourceNames);
			
			var targetNameDistance = umlTransition.target.name.fuzzyDistance(sfwTransition.destination.name);
			var similarTargetNames = umlTransition.target.name.fuzzyMatch(sfwTransition.destination.name);
			var choiceTargets = umlTransition.target.isTypeOf(UML!Pseudostate) and umlTransition.target.kind = UML!PseudostateKind#choice and sfwTransition.destination.isTypeOf(Simulink!Junction) and sfwTransition.destination.outgoingTransitions.size() >= 2;
			var targetNames;
			if (not similarTargetNames and not choiceTargets) {
				targetNames = "Distinct target";
				
				matchInfo.put("Target name distance", umlTransition.target.name + " <> " + sfwTransition.destination.name);
			} else {
				targetNames = "Similar target";
			}
			matchInfo.put(targetNames, similarTargetNames);
			
			var sameTrigger = umlTransition.trigger.matches(sfwTransition.trigger);
			var triggers;
			if (not sameTrigger) {
				triggers = "Distinct trigger";
				
				matchInfo.put("UML transition trigger", umlTransition.trigger);
				matchInfo.put("Stateflow transition trigger", sfwTransition.trigger);
			} else {
				triggers = "Same trigger";
			}
			matchInfo.put(triggers, sameTrigger);
			var sameGuard = umlTransition.`guard`.matches(sfwTransition.`guard`);
			var guards;
			if (not sameGuard) {
				guards = "Distinct guard";
				
				matchInfo.put("UML transition guard", umlTransition.`guard`);
				matchInfo.put("Stateflow transition guard", sfwTransition.`guard`);
			} else {
				guards = "Same guard";
			}
			matchInfo.put(guards, sameGuard);
			var sameActions = umlTransition.effect.matches(sfwTransition.triggeredActions);
			var actions;
			if (not sameActions) {
				actions = "Distinct actions";
				
				matchInfo.put("UML transition actions", umlTransition.effect);
				matchInfo.put("Stateflow transition actions", sfwTransition.triggeredActions);
			} else {
				actions = "Same actions";
			}
			matchInfo.put(actions, sameActions);
			
			return similarContainerNames and (similarSourceNames or choiceSources) and (similarTargetNames or choiceTargets)/* and sameTrigger and sameGuard and sameActions*/;
		}
	}

// Mapping rule: mr_0021
@lazy
rule MatchUMLTransitionTriggerAndStateflowTransitionTrigger
	match umlTrigger : UML!Trigger
	with sfwTrigger : Simulink!SFWTrigger
	{
		compare : umlTrigger.name.fuzzyMatch(sfwTrigger.statement)
	}

// Mapping rule: mr_0022
@lazy
rule MatchUMLTransitionGuardAndStateflowTransitionGuard
	match umlGuard : UML!Constraint
	with sfwGuard : Simulink!SFWGuard
	{
		compare : umlGuard.name.fuzzyMatch(sfwGuard.statement)
	}

// Mapping rule: mr_0023
@lazy
rule MatchUMLTransitionActionsAndStateflowTransitionActions
	match umlAction : UML!Behavior
	with sfwAction : Simulink!Action
	{
		compare : umlAction.name.fuzzyMatch(sfwAction.statement)
	}
	