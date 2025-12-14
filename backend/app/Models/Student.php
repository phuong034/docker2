<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $fillable = [
        'student_code',
        'full_name',
        'email',
        'phone',
        'date_of_birth',
        'class_name',
    ];

    protected $casts = [
        'date_of_birth' => 'date',
    ];
}

