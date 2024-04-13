import { Controller } from "@hotwired/stimulus"
import FullCalendar from 'fullcalendar';
import axios from 'axios';

export default class extends Controller {
  connect() {
    var calendarEl = document.getElementById('calendar');
    this.calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'timeGridWeek',
      selectable: true,
      selectMirror: true,
      selectOverlap: false,
      select: this.handleSelect.bind(this),
      eventClick: this.handleEventClick.bind(this),
      unselectAuto: true,
    });

    this.calendar.render();
    this.fetchEvents();
  }

  fetchEvents() {
    axios.get('/availabilities.json')
      .then(response => {
        response.data.forEach(event => {
          this.calendar.addEvent({
            id: event.id.toString(),
            title: 'Available',
            start: event.start_time,
            end: event.end_time,
            allDay: false,
            color: 'green'
          });
        });
      })
      .catch(error => console.error('Error fetching events:', error));
    axios.get(`/fitness_classes/by_trainer/${document.getElementById('user-id').value}.json`)
      .then(response => {
        response.data.forEach(event => {
          this.calendar.addEvent({
            id: event.id.toString(),
            title: event.group_session ? 'Group Session' : 'Personal Training Session',
            start: event.start_time,
            end: event.end_time,
            allDay: false,
            color: event.group_session ? 'purple' : 'red'
          });
        });
      })
      .catch(error => console.error('Error fetching events:', error));
  }

  handleSelect(info) {
    let today = new Date();
    if (info.start < today) {
      alert('Please select a timeslot after today\'s date.');
      return;
    }
    let title = prompt('Enter a title for this block: (Available or Group Session)', 'Available');
    if (title === "Available") {
      this.saveEvent(title, info.start, info.end, info.allDay, 'green');
    } else if (title === "Group Session") {
      this.createGroupSession(info.start, info.end, 'purple');
    } else {
      alert('Please enter either "Available" or "Group Session"');
      return;
    }
    this.calendar.unselect();
  }

  handleEventClick(info) {
    if (confirm("Are you sure you want to delete this event?")) {
      if (info.event.title === 'Available') {
        axios.delete(`/availabilities/${info.event.id}`)
        .then(response => {
          console.log('Event deleted!');
          info.event.remove();
        })
        .catch(error => {
          console.error('Error deleting event:', error);
          console.log(error.response.data)
        });
      } else {
        axios.delete(`/fitness_classes/${info.event.id}`)
        .then(response => {
          console.log('Event deleted!');
          info.event.remove();
        })
        .catch(error => {
          console.error('Error deleting event:', error);
          console.log(error.response.data)
        });
      }
    }
  }

  saveEvent(title, start, end, allDay, color) {
    axios.post('/availabilities', {
      availability: {
        trainer_id: document.getElementById('user-id').value,
        start_time: start,
        end_time: end
      }
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    }).then(response => {
      this.calendar.addEvent({
        id: response.data.id.toString(),
        title: title,
        start: start,
        end: end,
        allDay: allDay,
        color: color
      });
    }).catch(error => {
      console.error('Error saving event:', error);
      console.log(error.response.data)
    });
  }
  
  createGroupSession(start, end, color) {
    const modal = new bootstrap.Modal(document.getElementById('eventModal'), {
      keyboard: false
    });

    const trainer_id = document.getElementById('user-id').value;
  
    const startInput = document.getElementById('startTime');
    const endInput = document.getElementById('endTime');

    startInput.value = `${start.getFullYear()}-${('0' + (start.getMonth() + 1)).slice(-2)}-${('0' + start.getDate()).slice(-2)}T${('0' + start.getHours()).slice(-2)}:${('0' + start.getMinutes()).slice(-2)}`;
    endInput.value = `${end.getFullYear()}-${('0' + (end.getMonth() + 1)).slice(-2)}-${('0' + end.getDate()).slice(-2)}T${('0' + end.getHours()).slice(-2)}:${('0' + end.getMinutes()).slice(-2)}`;

    const exerciseRoutineCheckboxContainer = document.getElementById('exerciseRoutineChecklist');
    exerciseRoutineCheckboxContainer.innerHTML = '';

    fetch('/exercise_routines.json')
      .then(response => response.json())
      .then(data => {
        data.forEach(exercise_routine => {
          fetch(`/exercises/${exercise_routine.exercise_id}.json`)
            .then(response => response.json())
            .then(exercise => {
              const checkbox = document.createElement('input');
              checkbox.type = 'checkbox';
              checkbox.value = exercise_routine.id;
              checkbox.id = `exerciseRoutine_${exercise_routine.id}`;
              checkbox.className = 'form-check-input';
              
              const label = document.createElement('label');
              label.htmlFor = `exerciseRoutine_${exercise_routine.id}`;
              label.textContent = `${exercise.name}` + 
                                  (exercise_routine.repetitions ? ` (${exercise_routine.repetitions} reps)` : '') + 
                                  (exercise_routine.weight ? ` - ${exercise_routine.weight} lbs` : '') + 
                                  (exercise_routine.time ? ` - ${exercise_routine.time} min` : '') + 
                                  (exercise_routine.distance ? ` - ${exercise_routine.distance} mi` : '');
              label.className = 'form-check-label';
              
              const formCheck = document.createElement('div');
              formCheck.className = 'form-check';
              formCheck.appendChild(checkbox);
              formCheck.appendChild(label);
              
              exerciseRoutineCheckboxContainer.appendChild(formCheck);
            })
            .catch(error => {
              throw error;
            });
        });
      })
      .catch(error => console.error('Error fetching exercise routines:', error));
    
    const equipmentCheckboxContainer = document.getElementById('equipmentChecklist');
    equipmentCheckboxContainer.innerHTML = '';

    fetch('/equipment.json')
      .then(response => response.json())
      .then(data => {
        data.forEach(equipment => {
          const checkbox = document.createElement('input');
          checkbox.type = 'checkbox';
          checkbox.value = equipment.id;
          checkbox.id = `equipment_${equipment.id}`;
          checkbox.className = 'form-check-input';

          const label = document.createElement('label');
          label.htmlFor = `equipment_${equipment.id}`;
          label.textContent = equipment.name;
          label.className = 'form-check-label';

          const formCheck = document.createElement('div');
          formCheck.className = 'form-check';
          formCheck.appendChild(checkbox);
          formCheck.appendChild(label);

          equipmentCheckboxContainer.appendChild(formCheck);
        });
      })
      .catch(error => console.error('Error fetching equipment:', error));

    const roomSelect = document.getElementById('roomSelect');
    roomSelect.innerHTML = '';

    const queryParams = new URLSearchParams({
      start_time: startInput.value,
      end_time: endInput.value,
      member_count: 1
    }).toString();
  
    fetch(`/rooms/available_rooms.json?${queryParams}`, {
      method: 'GET',
      headers: {
          'Content-Type': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => {
        data.forEach(room => {
          const option = new Option(room.id);
          option.value = room.id;
          option.text = room.id;
          roomSelect.add(option);
        });
      });

    const confirmButton = document.getElementById('confirmButton');
    confirmButton.onclick = () => {
      const newStart = new Date(startInput.value);
      const newEnd = new Date(endInput.value);

      const selectedExerciseRoutineIds = [];
      const selectedEquipmentIds = [];

      const checkboxes = document.querySelectorAll('.form-check-input');
      checkboxes.forEach((checkbox) => {
          if (checkbox.checked) {
            if (checkbox.id.startsWith('exerciseRoutine')) {
              selectedExerciseRoutineIds.push(checkbox.value);
            } else if (checkbox.id.startsWith('equipment')) {
              selectedEquipmentIds.push(checkbox.value);
            }
          }
      });

      if (selectedExerciseRoutineIds.length === 0) {
        alert('Please select at least one exercise routine.');
      } else if (roomSelect.value === '') {
        alert('Please select a room.');
      } else {
        modal.hide();

        this.saveGroupSession(roomSelect.value, trainer_id, true, start, end, selectedExerciseRoutineIds, selectedEquipmentIds, color);
      }
    };
    
    modal.show();
  }

  saveGroupSession(room_id, trainer_id, group_session, start_time, end_time, exercise_routines, equipment, color) {
    axios.post('/fitness_classes', {
      fitness_class: {
        room_id: room_id,
        trainer_id: trainer_id,
        group_session: group_session,
        start_time: start_time,
        end_time: end_time,
      }
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    }).then(response => {
      const fitness_class_id = response.data.id;

      exercise_routines.forEach(exercise_routine_id => {
        axios.post('/fitness_class_exercise_routines', {
          fitness_class_exercise_routine: {
            fitness_class_id: fitness_class_id,
            exercise_routine_id: exercise_routine_id
          }
        }).catch(error => {
          console.error('Error saving fitness class exercise routine:', error);
          console.log(error.response.data)
        });
      });

      equipment.forEach(equipment_id => {
        axios.post('/fitness_class_equipments', {
          fitness_class_equipment: {
            fitness_class_id: fitness_class_id,
            equipment_id: equipment_id
          }
        }).catch(error => {
          console.error('Error saving fitness class equipment:', error);
          console.log(error.response.data)
        });
      });

      this.calendar.addEvent({
        id: fitness_class_id.toString(),
        title: 'Group Session',
        start: start_time,
        end: end_time,
        allDay: false,
        color: color
      });
    }).catch(error => {
      console.error('Error saving event:', error);
      console.log(error.response.data)
    });
  }  
}
