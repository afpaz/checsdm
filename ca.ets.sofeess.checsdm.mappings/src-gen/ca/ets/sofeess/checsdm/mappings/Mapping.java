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

import org.eclipse.emf.common.util.EMap;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Mapping</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getName <em>Name</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel <em>Mappings Model</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getLeft <em>Left</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getRight <em>Right</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#isMatching <em>Matching</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingRule <em>Mapping Rule</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.Mapping#getInfo <em>Info</em>}</li>
 * </ul>
 *
 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping()
 * @model
 * @generated
 */
public interface Mapping extends EObject {
	/**
	 * Returns the value of the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Name</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Name</em>' attribute.
	 * @see #setName(String)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_Name()
	 * @model
	 * @generated
	 */
	String getName();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getName <em>Name</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Name</em>' attribute.
	 * @see #getName()
	 * @generated
	 */
	void setName(String value);

	/**
	 * Returns the value of the '<em><b>Mappings Model</b></em>' container reference.
	 * It is bidirectional and its opposite is '{@link ca.ets.sofeess.checsdm.mappings.MappingsModel#getMappings <em>Mappings</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Mappings Model</em>' container reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Mappings Model</em>' container reference.
	 * @see #setMappingsModel(MappingsModel)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_MappingsModel()
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsModel#getMappings
	 * @model opposite="mappings" transient="false"
	 * @generated
	 */
	MappingsModel getMappingsModel();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel <em>Mappings Model</em>}' container reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Mappings Model</em>' container reference.
	 * @see #getMappingsModel()
	 * @generated
	 */
	void setMappingsModel(MappingsModel value);

	/**
	 * Returns the value of the '<em><b>Left</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Left</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Left</em>' reference.
	 * @see #setLeft(EObject)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_Left()
	 * @model
	 * @generated
	 */
	EObject getLeft();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getLeft <em>Left</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Left</em>' reference.
	 * @see #getLeft()
	 * @generated
	 */
	void setLeft(EObject value);

	/**
	 * Returns the value of the '<em><b>Right</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Right</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Right</em>' reference.
	 * @see #setRight(EObject)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_Right()
	 * @model
	 * @generated
	 */
	EObject getRight();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getRight <em>Right</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Right</em>' reference.
	 * @see #getRight()
	 * @generated
	 */
	void setRight(EObject value);

	/**
	 * Returns the value of the '<em><b>Matching</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Matching</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Matching</em>' attribute.
	 * @see #setMatching(boolean)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_Matching()
	 * @model
	 * @generated
	 */
	boolean isMatching();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#isMatching <em>Matching</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Matching</em>' attribute.
	 * @see #isMatching()
	 * @generated
	 */
	void setMatching(boolean value);

	/**
	 * Returns the value of the '<em><b>Mapping Rule</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Mapping Rule</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Mapping Rule</em>' attribute.
	 * @see #setMappingRule(String)
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_MappingRule()
	 * @model
	 * @generated
	 */
	String getMappingRule();

	/**
	 * Sets the value of the '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingRule <em>Mapping Rule</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Mapping Rule</em>' attribute.
	 * @see #getMappingRule()
	 * @generated
	 */
	void setMappingRule(String value);

	/**
	 * Returns the value of the '<em><b>Info</b></em>' map.
	 * The key is of type {@link java.lang.String},
	 * and the value is of type {@link java.lang.String},
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Info</em>' map isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Info</em>' map.
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsPackage#getMapping_Info()
	 * @model mapType="ca.ets.sofeess.checsdm.mappings.StringToObjectEntry&lt;org.eclipse.emf.ecore.EString, org.eclipse.emf.ecore.EString&gt;"
	 * @generated
	 */
	EMap<String, String> getInfo();

} // Mapping
