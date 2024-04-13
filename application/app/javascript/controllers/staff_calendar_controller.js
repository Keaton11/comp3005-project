import { Controller } from "@hotwired/stimulus"
import FullCalendar from 'fullcalendar';
import axios from 'axios';

export default class extends Controller {
  connect() {
    var calendarEl = document.getElementById('calendar');
    this.calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'timeGridWeek',
      selectable: false,
      selectMirror: true,
      selectOverlap: false,
      eventResizableFromStart: true,
      eventDurationEditable: true,
      editable: true,
      eventClick: this.handleEventClick.bind(this),
      eventDrop: this.handleEventUpdate.bind(this),
      eventResizeStop: this.handleEventUpdate.bind(this),
      unselectAuto: true,
    });

    this.calendar.render();
    this.fetchEvents();
  }

  fetchEvents() {
    axios.get('/fitness_classes/all_group_sessions.json')
      .then(response => {
        response.data.forEach(fitness_class => {
          this.calendar.addEvent({
            id: fitness_class.id.toString(),
            title: 'Group Fitness Class',
            start: fitness_class.start_time,
            end: fitness_class.end_time,
            allDay: false,
            color: 'purple',
          });
        });
      })
      .catch(error => console.error('Error fetching events:', error));
  }

  handleEventClick(info) {
    axios.get('/fitness_classes/details/' + info.event.id + '.json')
      .then(response => {
        
        const modal = new bootstrap.Modal(document.getElementById('eventModal'), {
          keyboard: false
        });

        document.getElementById('trainerName').innerText = response.data.fitness_class.trainer_id;
        document.getElementById('memberCount').innerText = response.data.member_count;

        document.getElementById('startTime').value = `${info.event.start.getFullYear()}-${('0' + (info.event.start.getMonth() + 1)).slice(-2)}-${('0' + info.event.start.getDate()).slice(-2)}T${('0' + info.event.start.getHours()).slice(-2)}:${('0' + info.event.start.getMinutes()).slice(-2)}`;
        document.getElementById('endTime').value = `${info.event.end.getFullYear()}-${('0' + (info.event.end.getMonth() + 1)).slice(-2)}-${('0' + info.event.end.getDate()).slice(-2)}T${('0' + info.event.end.getHours()).slice(-2)}:${('0' + info.event.end.getMinutes()).slice(-2)}`;

        document.getElementById('exerciseRoutineList').innerHTML = '';
        response.data.exercise_routines.forEach(exercise_routine => {
          fetch(`/exercises/${exercise_routine.exercise_id}.json`)
            .then(response => response.json())
            .then(exercise => {
              const li = document.createElement('li');
              li.className = 'list-group-item';
              li.textContent = exercise.name + 
                              (exercise_routine.repetitions ? ` (${exercise_routine.repetitions} reps)` : '') + 
                              (exercise_routine.weight ? ` - ${exercise_routine.weight} lbs` : '') + 
                              (exercise_routine.time ? ` - ${exercise_routine.time} min` : '') + 
                              (exercise_routine.distance ? ` - ${exercise_routine.distance} mi` : '');
              document.getElementById('exerciseRoutineList').appendChild(li);
            })
            .catch(error => {
              throw error;
            });
        });

        document.getElementById('equipmentList').innerHTML = '';
        response.data.equipment.forEach(equipment => {
          const li = document.createElement('li');
          li.className = 'list-group-item';
          li.textContent = equipment.name;
          document.getElementById('equipmentList').appendChild(li);
        });

        document.getElementById('roomId').innerText = response.data.fitness_class.room_id;

        const confirmButton = document.getElementById('confirmButton');
        
        confirmButton.onclick = () => {
          axios.delete(`/fitness_classes/${info.event.id}`)
          .then(response => {
            console.log('Event deleted!');
            info.event.remove();
          })
          .catch(error => {
            console.error('Error deleting event:', error);
            console.log(error.response.data)
          });

          modal.hide();
        };

        modal.show();
      })
      .catch(error => {
        console.error('Error fetching fitness class:', error);
        console.log(error.response.data)
      });
  }

  handleEventUpdate(info) {
    axios.patch(`/fitness_classes/${info.event.id}/update_times`, {
      start_time: info.event.start,
      end_time: info.event.end
    })
    .then(response => {
      console.log('Event updated!');
    })
    .catch(error => {
      console.error('Error updating event:', error);
      console.log(error.response.data)
    });
  }
}
