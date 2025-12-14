<?php

namespace App\Http\Controllers;

use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Validation\ValidationException;

class StudentController extends Controller
{
    public function index(): JsonResponse
    {
        $students = Student::orderBy('created_at', 'desc')->get();
        return response()->json($students);
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'student_code' => 'required|string|max:50|unique:students,student_code',
                'full_name' => 'required|string|max:255',
                'email' => 'nullable|email|max:255',
                'phone' => 'nullable|string|max:20',
                'date_of_birth' => 'nullable|date',
                'class_name' => 'nullable|string|max:100',
            ]);

            $student = Student::create($validated);

            return response()->json($student, 201);
        } catch (ValidationException $e) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        }
    }

    public function show($id): JsonResponse
    {
        $student = Student::findOrFail($id);
        return response()->json($student);
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $student = Student::findOrFail($id);

            $validated = $request->validate([
                'student_code' => 'required|string|max:50|unique:students,student_code,' . $id,
                'full_name' => 'required|string|max:255',
                'email' => 'nullable|email|max:255',
                'phone' => 'nullable|string|max:20',
                'date_of_birth' => 'nullable|date',
                'class_name' => 'nullable|string|max:100',
            ]);

            $student->update($validated);

            return response()->json($student);
        } catch (ValidationException $e) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        }
    }

    public function destroy($id): JsonResponse
    {
        $student = Student::findOrFail($id);
        $student->delete();

        return response()->json(['message' => 'Student deleted successfully']);
    }
}

