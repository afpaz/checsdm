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

package ca.ets.sofeess.checsdm4uss.mappingrules.ui.handlers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.concurrent.atomic.AtomicReference;

import org.eclipse.ant.core.AntRunner;
import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.core.runtime.jobs.Job;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.jface.viewers.ViewerFilter;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.dialogs.ElementTreeSelectionDialog;
import org.eclipse.ui.handlers.HandlerUtil;
import org.eclipse.ui.model.BaseWorkbenchContentProvider;
import org.eclipse.ui.model.WorkbenchLabelProvider;

import ca.ets.sofeess.checsdm4uss.mappingrules.ui.MappingRulesUIPlugin;

public class MapModelsHandler extends AbstractHandler {

	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		ISelection selection = HandlerUtil.getCurrentSelection(event);
		
		if (selection instanceof IStructuredSelection) {
			if (((IStructuredSelection) selection).toList().size() == 2) {
				IFile umlFile = null;
				IFile simulinkFile = null;
				for (Object element : ((IStructuredSelection) selection).toList()) {
					if (element instanceof IFile) {
						IFile file = (IFile) element;
						if (file.getFileExtension().equals("uml")) {
							umlFile = file;
						}
						if (file.getFileExtension().equals("simulink")) {
							simulinkFile = file;
						}
					}
				}
				if (umlFile != null && simulinkFile != null) {
					Object[] result = obtainMappingModelTargetLocation(umlFile.getProject());
					if (((Integer) result[0]) == ElementTreeSelectionDialog.OK) {
						mapModels(umlFile, simulinkFile, ((IResource) result[1]));
					}
				}
			} else {
				Display.getDefault().syncExec(new Runnable() {
					@Override
					public void run() {
						MessageDialog.openError(Display.getDefault().getActiveShell(),
								"Error!",
								"Select a UML model and a Simulink model to be mapped.");
					}
				});
			}
		}
		return null;
	}
	
	private Object[] obtainMappingModelTargetLocation(IProject currentProject) {
		final AtomicReference<IResource> selectedFolder = new AtomicReference<IResource>();
		final AtomicReference<Integer> returnCode = new AtomicReference<Integer>();
		Display.getDefault().syncExec(new Runnable() {
            public void run() {                   
                ElementTreeSelectionDialog dialog = new ElementTreeSelectionDialog(Display.getDefault().getActiveShell(), new WorkbenchLabelProvider(), new BaseWorkbenchContentProvider());
                dialog.setTitle("Target Folder Selection");
                dialog.setMessage("Choose a target folder:");
                dialog.setAllowMultiple(false);
                dialog.setInput(ResourcesPlugin.getWorkspace().getRoot());
                dialog.addFilter(new ViewerFilter() {
					
					@Override
					public boolean select(Viewer viewer, Object parentElement, Object element) {
						return (element instanceof IContainer);
					}
				});
                dialog.setInitialSelection(currentProject);
                dialog.open();
                Object[] results = dialog.getResult();
                	if ((results != null) && (results.length > 0) && (results[0] instanceof IResource)) {
                		selectedFolder.set((IResource) results[0]);
				} else {
					selectedFolder.set(null);
				}
                	returnCode.set(dialog.getReturnCode());
            }
        });
		Object[] result = { returnCode.get(), selectedFolder.get() };
		return result;
	}

	private void mapModels(IFile umlFile, IFile simulinkFile, IResource targetFolder) {
		Job job = new Job("Mapping " + umlFile.getName() + " and " + simulinkFile.getName() + "...") {
			@Override
			protected IStatus run(IProgressMonitor monitor) {
				try {
					File buildFile = generateBuild(umlFile, simulinkFile, targetFolder);
					
					runBuild(monitor, buildFile);
					
					Display.getDefault().syncExec(new Runnable() {
	                    @Override
	                    public void run() {
	                        MessageDialog.openInformation(Display.getDefault().getActiveShell(), 
	                        		"Information", 
	                        		"Mappings created.");
	                    }
	                });
					
				} catch (CoreException | FileNotFoundException e) {
					Status status = new Status(Status.ERROR, MappingRulesUIPlugin.PLUGIN_ID,
							"Error while mapping the models.", e);
					MappingRulesUIPlugin.getDefault().getLog().log(status);
					Display.getDefault().syncExec(new Runnable() {
						@Override
						public void run() {
							MessageDialog.openError(Display.getDefault().getActiveShell(),
									"Error!",
									"Error while mapping the models.");
						}
					});
				}
				return Status.OK_STATUS;
			}
		};
		job.setUser(true);
		job.schedule();
	}
	
	private File generateBuild(IFile umlFile, IFile simulinkFile, IResource targetFolder) throws FileNotFoundException {
		File buildFile = new File(umlFile.getProject().getLocation().toOSString() + File.separator + "build.xml");
		PrintWriter writer = new PrintWriter(buildFile);
		
		String umlModelName = umlFile.getName().substring(0, umlFile.getName().lastIndexOf("."));
		String simulinkModelName = simulinkFile.getName().substring(0, simulinkFile.getName().lastIndexOf("."));
		String mappingModelPath = targetFolder.getProjectRelativePath().toOSString();
		String mappingModelName = (umlModelName.equals(simulinkModelName)) ? umlModelName : umlModelName + "_" + simulinkModelName;
		
		writer.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + 
				"<project name=\"Mapping Rules\" default=\"compare\">\n" + 
				"\n" + 
				"    <target name=\"loadModels\">\n" + 
				"    		<epsilon.emf.loadRegisteredMetamodel metamodeluri=\"http://www.eclipse.org/uml2/5.0.0/UML\"/>\n" + 
				"    		<epsilon.emf.loadModel name=\"UML\" modelfile=\"" + umlFile.getProjectRelativePath() + "\" metamodeluri=\"http://www.eclipse.org/uml2/5.0.0/UML\" read=\"true\" store=\"false\"/>\n" + 
				"    		\n" + 
				"    		<epsilon.emf.loadRegisteredMetamodel metamodeluri=\"http://www.etsmtl.ca/sofeess/breesse/simulink/1.0\"/>\n" + 
				"    		<epsilon.emf.loadModel name=\"Simulink\" modelfile=\"" + simulinkFile.getProjectRelativePath() + "\" metamodeluri=\"http://www.etsmtl.ca/sofeess/breesse/simulink/1.0\" read=\"true\" store=\"false\"/>\n" + 
				"    		\n" + 
				"    		<epsilon.emf.loadRegisteredMetamodel metamodeluri=\"http://www.etsmtl.ca/sofeess/checsdm/mappings/1.0\"/>\n" + 
				"    		<epsilon.emf.loadModel name=\"Mappings\" modelfile=\"" + ((!mappingModelPath.equals("")) ? mappingModelPath + File.separator : "") + mappingModelName + ".mappings\" metamodeluri=\"http://www.etsmtl.ca/sofeess/checsdm/mappings/1.0\" read=\"false\" store=\"true\"/>\n" + 
				"    </target>\n" + 
				"	\n" + 
				"	<target name=\"compare\" depends=\"loadModels\">\n" + 
				"		<epsilon.ecl src=\"../ca.ets.sofeess.checsdm4uss.mappingrules/src/ca/ets/sofeess/checsdm4uss/mappingrules/Main.ecl\">\n" + 
				"			<model ref=\"UML\"/>\n" + 
				"			<model ref=\"Simulink\"/>\n" + 
				"			<model ref=\"Mappings\"/>\n" + 
				"		</epsilon.ecl>\n" + 
				"	</target>\n" + 
				"	\n" +  
				"	<target name=\"refresh\" depends=\"compare\">\n" + 
				"		<eclipse.refreshLocal resource=\".\" depth=\"infinite\" />\n" + 
				"	</target>\n" +
				"</project>\n" + 
				"");
		
		writer.flush();
		writer.close();
		return buildFile;
	}

	private void runBuild(IProgressMonitor monitor, File buildFile) throws CoreException {
		AntRunner runner = new AntRunner();
		runner.setBuildFileLocation(buildFile.getAbsolutePath());
		runner.run(monitor);
	}

}
