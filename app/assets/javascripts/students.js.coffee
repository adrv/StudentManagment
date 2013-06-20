$ ->

  students_recieved = (students_list)->
    $('#students_list').html poirot.studentsList(students_list)
  
  fetch_students = ->
    $.ajax
      type: "POST"
      dataType: "json"
      url: "/"
      success: students_recieved

  fetch_students()
  setInterval(fetch_students, 10000)

  $("#submit_btn").click ->
    $.ajax
      type: "POST"
      url: "/students"
      data: $("#new_student").serialize() 
      success: (students_list) ->
        students_recieved(students_list)
        alert('Студент был доавлен')
        fetch_students()
      error: (e)->
        alert e.responseText
    false
