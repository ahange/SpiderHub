<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<script src="../../js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/countup/jquery.countup.css" />
<script src="<%=request.getContextPath()%>/countup/jquery.countup.js"></script>
<script type="text/javascript">
function activity(){
	Addactivity();
	$("#start").hide();
	$("#end").css({'display':'block'});
	AddTimer();
}
function endActivity(){
	$.ajax({
		type : 'POST',
		url : 'endactivity.html',
		dataType : 'json',
		data : {},
		success : function(data) {
			
		}
		})
		$("#countdown").hide();
	$("#start").show();
	$("#end").css({'display':'none'});
}
function Addactivity(){
	var taskid = $("#tId").val();
	alert(taskid);
	$.ajax({
		type : 'POST',
		url : 'activity.html',
		dataType : 'json',
		
		data : {
			task : taskid
		},
		success : function(data) {
		
		}
		
	})
}
function AddTimer(){

	$("#countdown").countup();
	$("#countdown").show();
}
</script>


<div class="jumbotron">
	<h2>Task Details</h2>
	<table class="table table-hover">
		<%-- <tr>
			<th>ID</th>
			<td>${task.id}</td>
		</tr> --%>
		<tr>
			<th>Task Name</th>
			<td>${task.taskName}</td>
		</tr>
		<tr>
			<th>Description</th>
			<td>${task.taskDescription}</td>
		</tr>
		<tr>
			<th>Manager</th>
			<td>${project.createdUser.userName}</td>
		</tr>
	</table>
	<div id="countdown" ></div>
	<h2>Task Related Files</h2>
	<table class="table table-hover">
		<tr>
			<th>File Name</th>
			<th>File Type</th>
			<th>File Upload Date</th>
			<th>File Download</th>
		</tr>
		<c:forEach items="${fileModel}" var="file">
			<tr>
				<td>${file.fileName}</td>
				<td>${file.fileType}</td>
				<td>${file.uploadDate}</td>
				<td><a
					href="download.html?fileNameWithType=${file.fileName}.${file.fileType}&fileId=${file.fileId}">Download</a></td>
			</tr>
		</c:forEach>
	</table>
	

		<table class="table table-hover">
			<tr>
				<th>Activity id</th>
				<th>Activity complete</th>
				<th>Activity start Time</th>
				<th>activity endtime</th>
				<th>Task Id</th>
				<th>userName</th>
			</tr>
			<c:forEach items="${activityModel}" var="activity">
				<tr>
					<td>${activity.id}</td>
					<td>${activity.complete}</td>
					<td>${activity.startTime}</td>
					<td>${activity.endTime}</td>
					<td>${activity.activityOfTask.id}</td>
					<td>${activity.activityOfTaskByUser.userName}</td>
				</tr>
			</c:forEach>
		</table>
		
		<div id = "start">
			<input class="btn btn-primary" type="submit" name="action"
				value="Start Working" onclick="activity();"/>
			<input type="hidden" id="tId" value="${task.id}"></input>
		</div>
		
		<div id = "end" style = "display:none">
			<input class="btn btn-primary" type="submit" name="action"
				value="Take a Break" onclick="endActivity()"> </input>
		</div>

	<h2>Comments on task</h2>
	<c:if test="${not empty comments}">
		<c:forEach items="${comments}" var="c">

			<h4>${c.userComment.userName}:${c.commentDesc}</h4>

		</c:forEach>
	</c:if>
	<form:form modelAttribute="comment" role="form">
		<form:textarea path="commentDesc" rows="2" cols="30"
			class="form-control" required="required" />
		<input type="hidden" name="task" value="${task.id}" />
		<input class="btn btn-primary" type="submit" name="action"
			value="Comment">
	</form:form>
	<c:if test="${task.statusTasks.id==1 && empty activityId}">
		<a href="doneTask.html?tid=${task.id}&pid=${project.id}"><input
			name="action" type="submit" class="btn btn-warning"
			value="Finish Task" /></a>
	</c:if>
</div>
