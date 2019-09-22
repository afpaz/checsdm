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

import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;

/**
 * <!-- begin-user-doc -->
 * The <b>Package</b> for the model.
 * It contains accessors for the meta objects to represent
 * <ul>
 *   <li>each class,</li>
 *   <li>each feature of each class,</li>
 *   <li>each operation of each class,</li>
 *   <li>each enum,</li>
 *   <li>and each data type</li>
 * </ul>
 * <!-- end-user-doc -->
 * @see ca.ets.sofeess.checsdm.mappings.MappingsFactory
 * @model kind="package"
 * @generated
 */
public interface MappingsPackage extends EPackage {
	/**
	 * The package name.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNAME = "mappings";

	/**
	 * The package namespace URI.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNS_URI = "http://www.etsmtl.ca/sofeess/checsdm/mappings/1.0";

	/**
	 * The package namespace name.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String eNS_PREFIX = "mappings";

	/**
	 * The singleton instance of the package.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	MappingsPackage eINSTANCE = ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl.init();

	/**
	 * The meta object id for the '{@link ca.ets.sofeess.checsdm.mappings.impl.MappingsModelImpl <em>Model</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsModelImpl
	 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getMappingsModel()
	 * @generated
	 */
	int MAPPINGS_MODEL = 0;

	/**
	 * The feature id for the '<em><b>Mappings</b></em>' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPINGS_MODEL__MAPPINGS = 0;

	/**
	 * The number of structural features of the '<em>Model</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPINGS_MODEL_FEATURE_COUNT = 1;

	/**
	 * The number of operations of the '<em>Model</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPINGS_MODEL_OPERATION_COUNT = 0;

	/**
	 * The meta object id for the '{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl <em>Mapping</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingImpl
	 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getMapping()
	 * @generated
	 */
	int MAPPING = 1;

	/**
	 * The feature id for the '<em><b>Name</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__NAME = 0;

	/**
	 * The feature id for the '<em><b>Mappings Model</b></em>' container reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__MAPPINGS_MODEL = 1;

	/**
	 * The feature id for the '<em><b>Left</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__LEFT = 2;

	/**
	 * The feature id for the '<em><b>Right</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__RIGHT = 3;

	/**
	 * The feature id for the '<em><b>Matching</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__MATCHING = 4;

	/**
	 * The feature id for the '<em><b>Mapping Rule</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__MAPPING_RULE = 5;

	/**
	 * The feature id for the '<em><b>Info</b></em>' map.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING__INFO = 6;

	/**
	 * The number of structural features of the '<em>Mapping</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING_FEATURE_COUNT = 7;

	/**
	 * The number of operations of the '<em>Mapping</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int MAPPING_OPERATION_COUNT = 0;

	/**
	 * The meta object id for the '{@link ca.ets.sofeess.checsdm.mappings.impl.StringToObjectEntryImpl <em>String To Object Entry</em>}' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see ca.ets.sofeess.checsdm.mappings.impl.StringToObjectEntryImpl
	 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getStringToObjectEntry()
	 * @generated
	 */
	int STRING_TO_OBJECT_ENTRY = 2;

	/**
	 * The feature id for the '<em><b>Key</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STRING_TO_OBJECT_ENTRY__KEY = 0;

	/**
	 * The feature id for the '<em><b>Value</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STRING_TO_OBJECT_ENTRY__VALUE = 1;

	/**
	 * The number of structural features of the '<em>String To Object Entry</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STRING_TO_OBJECT_ENTRY_FEATURE_COUNT = 2;

	/**
	 * The number of operations of the '<em>String To Object Entry</em>' class.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 * @ordered
	 */
	int STRING_TO_OBJECT_ENTRY_OPERATION_COUNT = 0;


	/**
	 * Returns the meta object for class '{@link ca.ets.sofeess.checsdm.mappings.MappingsModel <em>Model</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Model</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsModel
	 * @generated
	 */
	EClass getMappingsModel();

	/**
	 * Returns the meta object for the containment reference list '{@link ca.ets.sofeess.checsdm.mappings.MappingsModel#getMappings <em>Mappings</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the containment reference list '<em>Mappings</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.MappingsModel#getMappings()
	 * @see #getMappingsModel()
	 * @generated
	 */
	EReference getMappingsModel_Mappings();

	/**
	 * Returns the meta object for class '{@link ca.ets.sofeess.checsdm.mappings.Mapping <em>Mapping</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>Mapping</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping
	 * @generated
	 */
	EClass getMapping();

	/**
	 * Returns the meta object for the attribute '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getName <em>Name</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Name</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getName()
	 * @see #getMapping()
	 * @generated
	 */
	EAttribute getMapping_Name();

	/**
	 * Returns the meta object for the container reference '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel <em>Mappings Model</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the container reference '<em>Mappings Model</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getMappingsModel()
	 * @see #getMapping()
	 * @generated
	 */
	EReference getMapping_MappingsModel();

	/**
	 * Returns the meta object for the reference '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getLeft <em>Left</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the reference '<em>Left</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getLeft()
	 * @see #getMapping()
	 * @generated
	 */
	EReference getMapping_Left();

	/**
	 * Returns the meta object for the reference '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getRight <em>Right</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the reference '<em>Right</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getRight()
	 * @see #getMapping()
	 * @generated
	 */
	EReference getMapping_Right();

	/**
	 * Returns the meta object for the attribute '{@link ca.ets.sofeess.checsdm.mappings.Mapping#isMatching <em>Matching</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Matching</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#isMatching()
	 * @see #getMapping()
	 * @generated
	 */
	EAttribute getMapping_Matching();

	/**
	 * Returns the meta object for the attribute '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getMappingRule <em>Mapping Rule</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Mapping Rule</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getMappingRule()
	 * @see #getMapping()
	 * @generated
	 */
	EAttribute getMapping_MappingRule();

	/**
	 * Returns the meta object for the map '{@link ca.ets.sofeess.checsdm.mappings.Mapping#getInfo <em>Info</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the map '<em>Info</em>'.
	 * @see ca.ets.sofeess.checsdm.mappings.Mapping#getInfo()
	 * @see #getMapping()
	 * @generated
	 */
	EReference getMapping_Info();

	/**
	 * Returns the meta object for class '{@link java.util.Map.Entry <em>String To Object Entry</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for class '<em>String To Object Entry</em>'.
	 * @see java.util.Map.Entry
	 * @model keyDataType="org.eclipse.emf.ecore.EString"
	 *        valueDataType="org.eclipse.emf.ecore.EString"
	 * @generated
	 */
	EClass getStringToObjectEntry();

	/**
	 * Returns the meta object for the attribute '{@link java.util.Map.Entry <em>Key</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Key</em>'.
	 * @see java.util.Map.Entry
	 * @see #getStringToObjectEntry()
	 * @generated
	 */
	EAttribute getStringToObjectEntry_Key();

	/**
	 * Returns the meta object for the attribute '{@link java.util.Map.Entry <em>Value</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the meta object for the attribute '<em>Value</em>'.
	 * @see java.util.Map.Entry
	 * @see #getStringToObjectEntry()
	 * @generated
	 */
	EAttribute getStringToObjectEntry_Value();

	/**
	 * Returns the factory that creates the instances of the model.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the factory that creates the instances of the model.
	 * @generated
	 */
	MappingsFactory getMappingsFactory();

	/**
	 * <!-- begin-user-doc -->
	 * Defines literals for the meta objects that represent
	 * <ul>
	 *   <li>each class,</li>
	 *   <li>each feature of each class,</li>
	 *   <li>each operation of each class,</li>
	 *   <li>each enum,</li>
	 *   <li>and each data type</li>
	 * </ul>
	 * <!-- end-user-doc -->
	 * @generated
	 */
	interface Literals {
		/**
		 * The meta object literal for the '{@link ca.ets.sofeess.checsdm.mappings.impl.MappingsModelImpl <em>Model</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsModelImpl
		 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getMappingsModel()
		 * @generated
		 */
		EClass MAPPINGS_MODEL = eINSTANCE.getMappingsModel();

		/**
		 * The meta object literal for the '<em><b>Mappings</b></em>' containment reference list feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPINGS_MODEL__MAPPINGS = eINSTANCE.getMappingsModel_Mappings();

		/**
		 * The meta object literal for the '{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl <em>Mapping</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingImpl
		 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getMapping()
		 * @generated
		 */
		EClass MAPPING = eINSTANCE.getMapping();

		/**
		 * The meta object literal for the '<em><b>Name</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute MAPPING__NAME = eINSTANCE.getMapping_Name();

		/**
		 * The meta object literal for the '<em><b>Mappings Model</b></em>' container reference feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPING__MAPPINGS_MODEL = eINSTANCE.getMapping_MappingsModel();

		/**
		 * The meta object literal for the '<em><b>Left</b></em>' reference feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPING__LEFT = eINSTANCE.getMapping_Left();

		/**
		 * The meta object literal for the '<em><b>Right</b></em>' reference feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPING__RIGHT = eINSTANCE.getMapping_Right();

		/**
		 * The meta object literal for the '<em><b>Matching</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute MAPPING__MATCHING = eINSTANCE.getMapping_Matching();

		/**
		 * The meta object literal for the '<em><b>Mapping Rule</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute MAPPING__MAPPING_RULE = eINSTANCE.getMapping_MappingRule();

		/**
		 * The meta object literal for the '<em><b>Info</b></em>' map feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EReference MAPPING__INFO = eINSTANCE.getMapping_Info();

		/**
		 * The meta object literal for the '{@link ca.ets.sofeess.checsdm.mappings.impl.StringToObjectEntryImpl <em>String To Object Entry</em>}' class.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @see ca.ets.sofeess.checsdm.mappings.impl.StringToObjectEntryImpl
		 * @see ca.ets.sofeess.checsdm.mappings.impl.MappingsPackageImpl#getStringToObjectEntry()
		 * @generated
		 */
		EClass STRING_TO_OBJECT_ENTRY = eINSTANCE.getStringToObjectEntry();

		/**
		 * The meta object literal for the '<em><b>Key</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute STRING_TO_OBJECT_ENTRY__KEY = eINSTANCE.getStringToObjectEntry_Key();

		/**
		 * The meta object literal for the '<em><b>Value</b></em>' attribute feature.
		 * <!-- begin-user-doc -->
		 * <!-- end-user-doc -->
		 * @generated
		 */
		EAttribute STRING_TO_OBJECT_ENTRY__VALUE = eINSTANCE.getStringToObjectEntry_Value();

	}

} //MappingsPackage
