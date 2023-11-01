import unittest
import requests

BASE_URL = "http://127.0.0.1:5000"
test_edit_tasktest_create_tasktest_delete_tasktest_edit_sprint
test_add_sprint_tasktest_revoke_sprint_tasktest_log_hours
# note: must initialise local database first
# to initialise : run table_creation_w_autoID.sql and sample_data_w_autoID.sql 

class APITest(unittest.TestCase):

     def test_edit_task(self):
        url = f"{BASE_URL}/edit_task/1"
        data = {
            "taskName": "Updated Task Name",
            "taskDesc": "Updated Task Description"
        }
        response = requests.put(url, json=data)
        print(response.json()['message'])
        self.assertEqual(response.status_code, 200)  #A successful edit returns a 200 status code
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()['message'],'Task updated successfully')

     def test_create_task(self):
        url = f"{BASE_URL}/create_task"
        data = {'taskName': 'insertion', 
                'taskType': 'story', 
                'taskNumStoryPoint': '3', 
                'taskPriority': 'medium', 
                'taskStatus': 'in-progress', 
                'taskStage': 'development', 
                'taskDesc': 'rewyerh', 
                'assigneeID': '3', 
                'tags': ['front-end', 'back-end']}

        response = requests.post(url, json=data)
        print(response.json()['message'])
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()['message'],'Task and tags created successfully')
        self.assertEqual(response.status_code, 201)  #A successful creation returns a 201 status code

     def test_delete_task(self):
        url = f"{BASE_URL}/delete_task/19"
        response = requests.delete(url)
        print(response.json()['message'])

        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()['message'], 'Task deleted successfully')
        self.assertEqual(response.status_code, 200)  # A successful deletion returns a 200 status code
    
     def test_create_sprint(self):
        url = f"{BASE_URL}/create_sprint"
        data = {'sprintName' : 'sprintName',
             'sprintStatus' : 'Not Started' ,
             'sprintStartDate' : '28-09-2023',
             'sprintEndDate' : None}
        
        data1 = {'sprintName' : 'test Sprint Name',
             'sprintStatus' : 'Not Started' ,
             'sprintStartDate' : '28-09-2023',
             'sprintEndDate' : "30-10-2023"}
        
        data2 = {'sprintName' : 'sprintName',
             'sprintStatus' : 'Not Started' ,
             'sprintStartDate' : None,
             'sprintEndDate' : None}
        
        response = requests.post(url, json=data)
        print(response.json()['message'])
        self.assertEqual(response.status_code, 201)  #A successful insert returns a 201 status code
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()['message'],'Sprint created successfully')

        response1 = requests.post(url, json=data1)
        print(response1.json()['message'])
        self.assertEqual(response1.status_code, 201)  #A successful insert returns a 201 status code
        self.assertTrue("success" in response1.json())
        self.assertEqual(response1.json()['message'],'Sprint created successfully')

        response2 = requests.post(url, json=data2)
        print(response2.json()['message'])
        self.assertEqual(response2.status_code, 201)  #A successful insert returns a 201 status code
        self.assertTrue("success" in response2.json())
        self.assertEqual(response2.json()['message'],'Sprint created successfully')

     def test_edit_sprint(self):
        url = f"{BASE_URL}/edit_sprint"
        data = {'sprintName' : 'editted sprint test 1',
             'sprintStatus' : 'Active' ,
             'sprintStartDate' : '28-09-2023',
             'sprintEndDate' : None}
        
        data1 = {'sprintName' : 'editted sprint test 2',
             'sprintStatus' : 'Completed' ,
             'sprintStartDate' : '28-09-2023',
             'sprintEndDate' : "30-10-2023"}
        
        data2 = {'sprintName' : 'editted sprint test 3',
             'sprintStatus' : 'Not Started' ,
             'sprintStartDate' : None,
             'sprintEndDate' : None}
        
        response = requests.put(f"{url}/1", json=data)
        print(response.json()['message'])
        self.assertEqual(response.status_code, 200)  #A successful edit returns a 201 status code
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()['message'],'Sprint updated successfully')

        response1 = requests.put(f"{url}/2", json=data1)
        print(response1.json()['message'])
        self.assertEqual(response1.status_code, 200)  
        self.assertTrue("success" in response1.json())
        self.assertEqual(response1.json()['message'],'Sprint updated successfully')

        response2 = requests.put(f"{url}/3", json=data2)
        print(response2.json()['message'])
        self.assertEqual(response2.status_code, 200)  
        self.assertTrue("success" in response2.json())
        self.assertEqual(response2.json()['message'],'Sprint updated successfully')
        
     def test_add_sprint_task(self):
        task_id = 1
        sprint_id = 1
        url = f"{BASE_URL}/add_sprint_task/{task_id}/{sprint_id}"
        response = requests.put(url)

        # Assert the response status code and message
        self.assertEqual(response.status_code, 200)
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()["message"], "Task added to sprint successfully")

     def test_revoke_sprint_task(self):
        task_id = 1

        # Make a PUT request to revoke the task from the sprint
        url = f"{BASE_URL}/revoke_sprint_task/{task_id}"
        response = requests.put(url)

        # Assert the response status code and message
        self.assertEqual(response.status_code, 200)
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()["message"], "Task added to sprint successfully")
     
     def test_log_hours(self):

        # Replace with valid data for testing
        data = {
            "sprintTaskID": 1,
            "logDate": "01-01-2023",
            "hoursLogged": 5.5
        }

        # Make a POST request to log hours
        url = f"{BASE_URL}/log_hours"
        response = requests.post(url, json=data)

        # Assert the response status code and message
        self.assertEqual(response.status_code, 201)
        self.assertTrue("success" in response.json())
        self.assertEqual(response.json()["message"], "Hours logged successfully")

if __name__ == '__main__':
    unittest.main()
