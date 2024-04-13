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
      eventClick: this.handleEventClick.bind(this),
      unselectAuto: true,
    });

    this.calendar.render();
    this.fetchEvents();
  }

  fetchEvents() {
    axios.get('/availabilities/all.json')
      .then(response => {
        response.data.forEach(event => {
          axios.get('/trainers/' + event.trainer_id + '.json')
            .then(response => {
              this.calendar.addEvent({
                id: event.id.toString(),
                title: 'Trainer: ' + response.data.id.toString(),
                start: event.start_time,
                end: event.end_time,
                allDay: false,
                color: 'green',
              });
            })
            .catch(error => {
              throw error;
            });
        });
      })
      .catch(error => {
        console.error('Error fetching events:', error);
        console.log(error.response.data)
      });
    axios.get('/fitness_class_members/for_member_non_grouped/' + document.getElementById('user-id').value + '.json')
      .then(response => {
        response.data.forEach(fitness_class => {
          this.calendar.addEvent({
            id: fitness_class.id.toString(),
            title: 'Fitness Class',
            start: fitness_class.start_time,
            end: fitness_class.end_time,
            allDay: false,
            color: 'blue',
          });
        });
      })
      .catch(error => console.error('Error fetching events:', error));
    axios.get('/fitness_classes/group_sessions/' + document.getElementById('user-id').value + '.json')
      .then(response => {
        response.data.forEach(fitness_class => {
          this.calendar.addEvent({
            id: fitness_class.id.toString(),
            title: 'Group Fitness Class',
            start: fitness_class.start_time,
            end: fitness_class.end_time,
            allDay: false,
            color: fitness_class.member_participates ? 'blue' : 'purple',
          });
        });
      })
      .catch(error => console.error('Error fetching events:', error));
  }

  handleEventClick(info) {
    if (info.event.title.includes('Trainer')) {
      
      const modal = new bootstrap.Modal(document.getElementById('eventModal'), {
        keyboard: false
      });
    
      const startInput = document.getElementById('startTime');
      const endInput = document.getElementById('endTime');
      const trainerName = document.getElementById('trainerName');
    
      const originalStartInput = info.event.start;
      const originalEndInput = info.event.end;
      const availability_id = info.event.id;
      console.log(availability_id);
      const trainer_id = info.event.title.split(':')[1].trim();

      startInput.value = `${originalStartInput.getFullYear()}-${('0' + (originalStartInput.getMonth() + 1)).slice(-2)}-${('0' + originalStartInput.getDate()).slice(-2)}T${('0' + originalStartInput.getHours()).slice(-2)}:${('0' + originalStartInput.getMinutes()).slice(-2)}`;
      endInput.value = `${originalEndInput.getFullYear()}-${('0' + (originalEndInput.getMonth() + 1)).slice(-2)}-${('0' + originalEndInput.getDate()).slice(-2)}T${('0' + originalEndInput.getHours()).slice(-2)}:${('0' + originalEndInput.getMinutes()).slice(-2)}`;

      trainerName.innerText = trainer_id;

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
        member_count: 2
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

        if (newStart < originalStartInput || newEnd > originalEndInput) {
          alert('Invalid times. Please select a time within the original range.');
        } else if (selectedExerciseRoutineIds.length === 0) {
          alert('Please select at least one exercise routine.');
        } else if (roomSelect.value === '') {
          alert('Please select a room.');
        } else {
          modal.hide();

          this.saveEvent(roomSelect.value, trainer_id, false, newStart, newEnd, document.getElementById('user-id').value, selectedExerciseRoutineIds, selectedEquipmentIds);
          this.updateAvailability(availability_id, trainer_id, originalStartInput, originalEndInput, newStart, newEnd);
        }
      };
    
      modal.show();
    } else {
      if (info.event.title.includes('Group')) {
        axios.get('/fitness_classes/details/' + info.event.id + '.json')
          .then(response => {
            
            const modal = new bootstrap.Modal(document.getElementById('eventModal2'), {
              keyboard: false
            });

            document.getElementById('trainerName2').innerText = response.data.fitness_class.trainer_id;
            document.getElementById('memberCount').innerText = response.data.member_count;

            document.getElementById('startTime2').value = `${info.event.start.getFullYear()}-${('0' + (info.event.start.getMonth() + 1)).slice(-2)}-${('0' + info.event.start.getDate()).slice(-2)}T${('0' + info.event.start.getHours()).slice(-2)}:${('0' + info.event.start.getMinutes()).slice(-2)}`;
            document.getElementById('endTime2').value = `${info.event.end.getFullYear()}-${('0' + (info.event.end.getMonth() + 1)).slice(-2)}-${('0' + info.event.end.getDate()).slice(-2)}T${('0' + info.event.end.getHours()).slice(-2)}:${('0' + info.event.end.getMinutes()).slice(-2)}`;

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

            const confirmButton = document.getElementById('confirmButton2');

            if (info.event.backgroundColor === 'purple') {
              confirmButton.innerText = 'Join';

              confirmButton.onclick = () => {
                axios.post('/fitness_class_members', {
                  fitness_class_member: {
                    fitness_class_id: info.event.id,
                    member_id: document.getElementById('user-id').value
                  }
                }).catch(error => {
                  console.error('Error saving fitness class member:', error);
                  console.log(error.response.data)
                });

                axios.post('/bills', {
                  bill: {
                    member_id: document.getElementById('user-id').value,
                    name: `Fitness Class (Group): ${info.event.id}`,
                    date: info.event.start.toISOString().split('T')[0],
                    cost: 25,
                    paid: false
                  }
                }).catch(error => {
                  console.error('Error saving bill:', error);
                  console.log(error.response.data)
                });

                info.event.setProp('backgroundColor', 'blue');
                info.event.setProp('borderColor', 'blue');

                modal.hide();
              };
            } else {
              confirmButton.innerText = 'Leave';

              confirmButton.onclick = () => {
                axios.delete(`/fitness_class_members/destroy_by_member_and_class/${info.event.id}/${document.getElementById('user-id').value}.json`, {
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                  }
                })
                .then(response => {
                  info.event.setProp('backgroundColor', 'purple');
                  info.event.setProp('borderColor', 'purple');
                })
                .catch(error => {
                  console.error('Error deleting fitness class member:', error);
                  console.log(error.response.data)
                });

                axios.delete(`/bills/delete_group_fitness_class?member_id=${document.getElementById('user-id').value}&id=${info.event.id}`)
                  .then(response => {
                    console.log('Fitness class bill deleted successfully.');
                  })
                  .catch(error => {
                    console.error('Error deleting bill:', error);
                    if (error.response) {
                      console.log(error.response.data);
                    }
                  });

                modal.hide();
              }
            }

            modal.show();
          })
          .catch(error => {
            console.error('Error fetching fitness class:', error);
            console.log(error.response.data)
          });
      } else {
        if (confirm("Are you sure you want to delete this event?")) {
          this.deleteEvent(info.event.id);
        }
      }
    }
  }

  saveEvent(room_id, trainer_id, group_session, start_time, end_time, member_id, exercise_routines, equipment) {
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
      
      axios.post('/fitness_class_members', {
        fitness_class_member: {
          fitness_class_id: fitness_class_id,
          member_id: member_id
        }
      }).catch(error => {
        console.error('Error saving fitness class member:', error);
        console.log(error.response.data)
      });

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

      console.log(start_time)

      axios.post('/bills', {
        bill: {
          member_id: member_id,
          name: `Fitness Class (Personal): ${fitness_class_id}`,
          date: start_time.toISOString().split('T')[0],
          cost: 50,
          paid: false
        }
      }).catch(error => {
        console.error('Error saving bill:', error);
        console.log(error.response.data)
      });

      this.calendar.addEvent({
        id: fitness_class_id.toString(),
        title: 'Personal Training Session',
        start: start_time,
        end: end_time,
        allDay: false,
        color: 'blue'
      });
    }).catch(error => {
      console.error('Error saving event:', error);
      console.log(error.response.data)
    });
  }  

  deleteEvent(fitnessClassId) {
    axios.delete(`/fitness_classes/${fitnessClassId}`, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(response => {
      console.log('Fitness class and all related data deleted successfully');
      this.calendar.getEventById(fitnessClassId).remove();

      console.log(document.getElementById('user-id').value)
      console.log(fitnessClassId)
      axios.delete(`/bills/delete_personal_fitness_class?member_id=${document.getElementById('user-id').value}&id=${fitnessClassId}`)
        .then(response => {
          console.log('Fitness class bill deleted successfully.');
        })
        .catch(error => {
          console.error('Error deleting bill:', error);
          if (error.response) {
            console.log(error.response.data);
          }
        });
    })
    .catch(error => {
      console.error('Error deleting fitness class:', error);
      if (error.response) {
        console.log(error.response.data);
      }
    });
  }

  updateAvailability(availabilityId, trainerId, prevStart, prevEnd, classStart, classEnd) {
    axios.delete(`/availabilities/${availabilityId}.json`, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .catch(error => { console.error('Error deleting availability:', error); });

    this.calendar.getEventById(availabilityId).remove();

    if (prevStart < classStart) {
      axios.post('/availabilities', {
        availability: {
          trainer_id: trainerId,
          start_time: prevStart.toISOString(),
          end_time: classStart.toISOString()
        }
      }, {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      }).then(response => {
        this.calendar.addEvent({
          id: response.data.id.toString(),
          title: 'Trainer: ' + trainerId,
          start: prevStart,
          end: classStart,
          allDay: false,
          color: 'green'
        });
      }).catch(error => {
        console.error('Error saving event:', error);
        console.log(error.response.data)
      });
    }

    if (prevEnd > classEnd) {
      axios.post('/availabilities', {
        availability: {
          trainer_id: trainerId,
          start_time: classEnd.toISOString(),
          end_time: prevEnd.toISOString()
        }
      }, {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      }).then(response => {
        this.calendar.addEvent({
          id: response.data.id.toString(),
          title: 'Trainer: ' + trainerId,
          start: classEnd,
          end: prevEnd,
          allDay: false,
          color: 'green'
        });
      }).catch(error => {
        console.error('Error saving event:', error);
        console.log(error.response.data)
      });
    }
  }
}
