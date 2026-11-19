import jenkins.model.Jenkins
import org.jenkinsci.plugins.workflow.job.WorkflowJob
import org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition
def instance = Jenkins.get()
def job = instance.getItem('lab08-last-two-commits')
if (job == null) {
  job = instance.createProject(WorkflowJob, 'lab08-last-two-commits')
  job.setDefinition(new CpsFlowDefinition(new File('/usr/share/jenkins/ref/lab.Jenkinsfile').text, true))
  job.save()
  job.scheduleBuild2(0)
}
