//
//  AnywhereFitnessTests.swift
//  AnywhereFitnessTests
//
//  Created by Lambda_School_Loaner_204 on 1/10/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import XCTest
@testable import AnywhereFitness

class AnywhereFitnessTests: XCTestCase {

    func testGetFitnessClasses() {
        let databaseController = DatabaseController()
        let userRep = UserRepresentation(username: "test", password: "password", isInstructor: nil)
        let getClasses = expectation(description: "Got all Classes")

        var fitnessClasses = [FitnessClassRepresentation]()

        databaseController.signIn(with: userRep) { _ in
            databaseController.getAllClasses { (data, error) in
                guard let data = data else { return }
                fitnessClasses = data
                getClasses.fulfill()
            }
        }

        wait(for: [getClasses], timeout: 10)
        XCTAssertTrue(fitnessClasses.count > 0)
    }

    func testLoginAsInstructor() {
        let databaseController = DatabaseController()
        let login = expectation(description: "Login Successful")
        let userRep = UserRepresentation(username: "test", password: "password", isInstructor: nil)
        databaseController.signIn(with: userRep) { error in
            if let error = error {
                print(error)
            } else {
                login.fulfill()
            }
        }

        wait(for: [login], timeout: 10)

        XCTAssertNotNil(databaseController.loginStruct)
        XCTAssertTrue(!databaseController.loginStruct!.token.isEmpty)
        XCTAssertTrue(databaseController.loginStruct!.roleId % 2 == 0)
    }

    func testLoginAsClient() {
        let databaseController = DatabaseController()
        let login = expectation(description: "Login Successful")
        let userRep = UserRepresentation(username: "Marshall", password: "Marshall", isInstructor: nil)
        databaseController.signIn(with: userRep) { error in
            if let error = error {
                print(error)
            } else {
                login.fulfill()
            }
        }

        wait(for: [login], timeout: 10)

        XCTAssertNotNil(databaseController.loginStruct)
        XCTAssertTrue(!databaseController.loginStruct!.token.isEmpty)
        XCTAssertFalse(databaseController.loginStruct!.roleId % 2 == 0)
    }

    func testCreateFitnessClass() {
        let login = expectation(description: "Login Successful")
        let userController = UserController()
        let fitnessClasses = [FitnessClassRepresentation]()
        let userRep = UserRepresentation(username: "test", password: "password", isInstructor: nil)
        DatabaseController.sharedDatabaseController.signIn(with: userRep) { error in
            if let error = error {
                print(error)
            } else {
                login.fulfill()
            }
        }

        wait(for: [login], timeout: 10)

        userController.setUser(user: userRep, fitnessClasses: fitnessClasses)

        XCTAssertNotNil(DatabaseController.sharedDatabaseController.loginStruct)
        XCTAssertTrue(!DatabaseController.sharedDatabaseController.loginStruct!.token.isEmpty)
        XCTAssertTrue(DatabaseController.sharedDatabaseController.loginStruct!.roleId % 2 == 0)

        let fitnessClass = FitnessClass(name: "test", classType: "cardio", startTime: "2020-01-13T16:30:00.000Z", duration: "1hr", intensity: 5, location: "Gym", maxSize: 10)
        let classCreated = expectation(description: "Class Created")
        userController.createFitnessClass(fitnessClass: fitnessClass) {
            classCreated.fulfill()
        }

        wait(for: [classCreated], timeout: 50)

        XCTAssertTrue(userController.classes.count > 0)
    }

    func testUpdateLocalFitnessClass() {
        let userController = UserController()
        let fitnessClassRep = FitnessClassRepresentation(id: 2, name: "test", type: "cardio", startTime: "5:00PM", duration: "1hr", intensity: 3, location: "Gym", maxSize: 20)
        userController.classes.append(fitnessClassRep)

        let fitnessClassUpdate = FitnessClass(name: "test", classType: "cardio", startTime: "4:30", duration: "1hr", intensity: 5, location: "Gym", maxSize: 10)

        let _ = userController.updateClass(for: fitnessClassRep, with: fitnessClassUpdate)

        XCTAssertTrue(userController.classes[0].startTime == "4:30")
        XCTAssertTrue(userController.classes[0].intensity == 5)
        XCTAssertTrue(userController.classes[0].maxSize == 10)
    }

}
