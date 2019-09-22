/**
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
package ca.ets.sofeess.checsdm.mappings;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Model</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.MappingsModel#getMappings <em>Mappings</em>}</li>
 * </ul>
 *
 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMappingsModel()
 * @model
 * @generated
 */
public interface MappingsModel extends EObject {
	/**
	 * Returns the value of the '<em><b>Mappings</b></em>' containment reference list.
	 * The list contents are of type {@link ca.ets.sofeess.checsdm.mappings.Mapping}.
	 * It is bidirectional and its opposite is '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel <em>Mappings Model</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Mappings</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Mappings</em>' containment reference list.
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMappingsModel_Mappings()
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel
	 * @model opposite="mappingsModel" containment="true"
	 * @generated
	 */
	EList<Mapping> getMappings();

} // MappingsModel
