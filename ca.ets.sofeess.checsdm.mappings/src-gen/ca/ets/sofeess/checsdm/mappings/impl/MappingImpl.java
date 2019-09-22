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
package ca.ets.sofeess.checsdm.mappings.impl;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EMap;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import org.eclipse.emf.ecore.util.EcoreEMap;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.util.InternalEList;

import ca.ets.sofeess.checsdm.mappings.Mapping;
import ca.ets.sofeess.checsdm.mappings.MappingsModel;
import ca.ets.sofeess.checsdm.mappings.MappingsPackage;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Mapping</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * </p>
 * <ul>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getName <em>Name</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getMappingsModel <em>Mappings Model</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getLeft <em>Left</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getRight <em>Right</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#isMatching <em>Matching</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getMappingRule <em>Mapping Rule</em>}</li>
 *   <li>{@link ca.ets.sofeess.checsdm.mappings.impl.MappingImpl#getInfo <em>Info</em>}</li>
 * </ul>
 *
 * @generated
 */
public class MappingImpl extends MinimalEObjectImpl.Container implements Mapping {
	/**
	 * The default value of the '{@link #getName() <em>Name</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getName()
	 * @generated
	 * @ordered
	 */
	protected static final String NAME_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getName() <em>Name</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getName()
	 * @generated
	 * @ordered
	 */
	protected String name = NAME_EDEFAULT;

	/**
	 * The cached value of the '{@link #getLeft() <em>Left</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getLeft()
	 * @generated
	 * @ordered
	 */
	protected EObject left;

	/**
	 * The cached value of the '{@link #getRight() <em>Right</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getRight()
	 * @generated
	 * @ordered
	 */
	protected EObject right;

	/**
	 * The default value of the '{@link #isMatching() <em>Matching</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #isMatching()
	 * @generated
	 * @ordered
	 */
	protected static final boolean MATCHING_EDEFAULT = false;

	/**
	 * The cached value of the '{@link #isMatching() <em>Matching</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #isMatching()
	 * @generated
	 * @ordered
	 */
	protected boolean matching = MATCHING_EDEFAULT;

	/**
	 * The default value of the '{@link #getMappingRule() <em>Mapping Rule</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getMappingRule()
	 * @generated
	 * @ordered
	 */
	protected static final String MAPPING_RULE_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getMappingRule() <em>Mapping Rule</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getMappingRule()
	 * @generated
	 * @ordered
	 */
	protected String mappingRule = MAPPING_RULE_EDEFAULT;

	/**
	 * The cached value of the '{@link #getInfo() <em>Info</em>}' map.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getInfo()
	 * @generated
	 * @ordered
	 */
	protected EMap<String, String> info;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected MappingImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return MappingsPackage.Literals.MAPPING;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getName() {
		return name;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setName(String newName) {
		String oldName = name;
		name = newName;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__NAME, oldName, name));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public MappingsModel getMappingsModel() {
		if (eContainerFeatureID() != MappingsPackage.MAPPING__MAPPINGS_MODEL) return null;
		return (MappingsModel)eInternalContainer();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public NotificationChain basicSetMappingsModel(MappingsModel newMappingsModel, NotificationChain msgs) {
		msgs = eBasicSetContainer((InternalEObject)newMappingsModel, MappingsPackage.MAPPING__MAPPINGS_MODEL, msgs);
		return msgs;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setMappingsModel(MappingsModel newMappingsModel) {
		if (newMappingsModel != eInternalContainer() || (eContainerFeatureID() != MappingsPackage.MAPPING__MAPPINGS_MODEL && newMappingsModel != null)) {
			if (EcoreUtil.isAncestor(this, newMappingsModel))
				throw new IllegalArgumentException("Recursive containment not allowed for " + toString());
			NotificationChain msgs = null;
			if (eInternalContainer() != null)
				msgs = eBasicRemoveFromContainer(msgs);
			if (newMappingsModel != null)
				msgs = ((InternalEObject)newMappingsModel).eInverseAdd(this, MappingsPackage.MAPPINGS_MODEL__MAPPINGS, MappingsModel.class, msgs);
			msgs = basicSetMappingsModel(newMappingsModel, msgs);
			if (msgs != null) msgs.dispatch();
		}
		else if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__MAPPINGS_MODEL, newMappingsModel, newMappingsModel));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EObject getLeft() {
		if (left != null && left.eIsProxy()) {
			InternalEObject oldLeft = (InternalEObject)left;
			left = eResolveProxy(oldLeft);
			if (left != oldLeft) {
				if (eNotificationRequired())
					eNotify(new ENotificationImpl(this, Notification.RESOLVE, MappingsPackage.MAPPING__LEFT, oldLeft, left));
			}
		}
		return left;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EObject basicGetLeft() {
		return left;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setLeft(EObject newLeft) {
		EObject oldLeft = left;
		left = newLeft;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__LEFT, oldLeft, left));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EObject getRight() {
		if (right != null && right.eIsProxy()) {
			InternalEObject oldRight = (InternalEObject)right;
			right = eResolveProxy(oldRight);
			if (right != oldRight) {
				if (eNotificationRequired())
					eNotify(new ENotificationImpl(this, Notification.RESOLVE, MappingsPackage.MAPPING__RIGHT, oldRight, right));
			}
		}
		return right;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EObject basicGetRight() {
		return right;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setRight(EObject newRight) {
		EObject oldRight = right;
		right = newRight;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__RIGHT, oldRight, right));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public boolean isMatching() {
		return matching;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setMatching(boolean newMatching) {
		boolean oldMatching = matching;
		matching = newMatching;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__MATCHING, oldMatching, matching));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getMappingRule() {
		return mappingRule;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setMappingRule(String newMappingRule) {
		String oldMappingRule = mappingRule;
		mappingRule = newMappingRule;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, MappingsPackage.MAPPING__MAPPING_RULE, oldMappingRule, mappingRule));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EMap<String, String> getInfo() {
		if (info == null) {
			info = new EcoreEMap<String,String>(MappingsPackage.Literals.STRING_TO_OBJECT_ENTRY, StringToObjectEntryImpl.class, this, MappingsPackage.MAPPING__INFO);
		}
		return info;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eInverseAdd(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
		switch (featureID) {
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				if (eInternalContainer() != null)
					msgs = eBasicRemoveFromContainer(msgs);
				return basicSetMappingsModel((MappingsModel)otherEnd, msgs);
		}
		return super.eInverseAdd(otherEnd, featureID, msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
		switch (featureID) {
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				return basicSetMappingsModel(null, msgs);
			case MappingsPackage.MAPPING__INFO:
				return ((InternalEList<?>)getInfo()).basicRemove(otherEnd, msgs);
		}
		return super.eInverseRemove(otherEnd, featureID, msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eBasicRemoveFromContainerFeature(NotificationChain msgs) {
		switch (eContainerFeatureID()) {
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				return eInternalContainer().eInverseRemove(this, MappingsPackage.MAPPINGS_MODEL__MAPPINGS, MappingsModel.class, msgs);
		}
		return super.eBasicRemoveFromContainerFeature(msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case MappingsPackage.MAPPING__NAME:
				return getName();
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				return getMappingsModel();
			case MappingsPackage.MAPPING__LEFT:
				if (resolve) return getLeft();
				return basicGetLeft();
			case MappingsPackage.MAPPING__RIGHT:
				if (resolve) return getRight();
				return basicGetRight();
			case MappingsPackage.MAPPING__MATCHING:
				return isMatching();
			case MappingsPackage.MAPPING__MAPPING_RULE:
				return getMappingRule();
			case MappingsPackage.MAPPING__INFO:
				if (coreType) return getInfo();
				else return getInfo().map();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case MappingsPackage.MAPPING__NAME:
				setName((String)newValue);
				return;
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				setMappingsModel((MappingsModel)newValue);
				return;
			case MappingsPackage.MAPPING__LEFT:
				setLeft((EObject)newValue);
				return;
			case MappingsPackage.MAPPING__RIGHT:
				setRight((EObject)newValue);
				return;
			case MappingsPackage.MAPPING__MATCHING:
				setMatching((Boolean)newValue);
				return;
			case MappingsPackage.MAPPING__MAPPING_RULE:
				setMappingRule((String)newValue);
				return;
			case MappingsPackage.MAPPING__INFO:
				((EStructuralFeature.Setting)getInfo()).set(newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case MappingsPackage.MAPPING__NAME:
				setName(NAME_EDEFAULT);
				return;
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				setMappingsModel((MappingsModel)null);
				return;
			case MappingsPackage.MAPPING__LEFT:
				setLeft((EObject)null);
				return;
			case MappingsPackage.MAPPING__RIGHT:
				setRight((EObject)null);
				return;
			case MappingsPackage.MAPPING__MATCHING:
				setMatching(MATCHING_EDEFAULT);
				return;
			case MappingsPackage.MAPPING__MAPPING_RULE:
				setMappingRule(MAPPING_RULE_EDEFAULT);
				return;
			case MappingsPackage.MAPPING__INFO:
				getInfo().clear();
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case MappingsPackage.MAPPING__NAME:
				return NAME_EDEFAULT == null ? name != null : !NAME_EDEFAULT.equals(name);
			case MappingsPackage.MAPPING__MAPPINGS_MODEL:
				return getMappingsModel() != null;
			case MappingsPackage.MAPPING__LEFT:
				return left != null;
			case MappingsPackage.MAPPING__RIGHT:
				return right != null;
			case MappingsPackage.MAPPING__MATCHING:
				return matching != MATCHING_EDEFAULT;
			case MappingsPackage.MAPPING__MAPPING_RULE:
				return MAPPING_RULE_EDEFAULT == null ? mappingRule != null : !MAPPING_RULE_EDEFAULT.equals(mappingRule);
			case MappingsPackage.MAPPING__INFO:
				return info != null && !info.isEmpty();
		}
		return super.eIsSet(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public String toString() {
		if (eIsProxy()) return super.toString();

		StringBuffer result = new StringBuffer(super.toString());
		result.append(" (name: ");
		result.append(name);
		result.append(", matching: ");
		result.append(matching);
		result.append(", mappingRule: ");
		result.append(mappingRule);
		result.append(')');
		return result.toString();
	}

} //MappingImpl
