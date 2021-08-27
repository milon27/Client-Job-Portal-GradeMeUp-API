import { Request, Response } from "express";
import { PrismaClient, candidate } from "@prisma/client";
import ApiResponse from '../../models/ApiResponse';
import Define from "../../utils/Define";
import Helper from "../../utils/Helper";
import bcryptjs from 'bcryptjs'
import moment from 'moment'

const db = new PrismaClient()


const CandidateController = {
    /**
     * @description
     * 
     * 
     * @response {error(boolean), message(String), response(object:USER)}
     */
    signUpCandidate: async (req: Request, res: Response) => {

        try {
            const {
                name,
                email,
                phone,
                password,
                image_url,
                gender,
                dob,
                country,
                region,
                full_address,
                zip_code,
                private_val,
                job_type,
                work_experience,
                work_area_radius,
                working_hour_per_week,
                salary_per_hour,
                salary_per_month,
                availability_date,
                work_shift,
                certificate,
                other_certificate,
                license,
                it_skills,
                expected_benefits,
                current_employment,
                languages,
                job_profession_id
            } = req.body


            if (password.length < 6) {
                throw new Error("Password Length Should be More than 5 character.")
            }
            //get hash pass & save new user into db
            const hashpass = await bcryptjs.hash(password, await bcryptjs.genSalt(10))

            //check alreay used or not
            const u = await db.candidate.findUnique({
                where: {
                    email: email
                }
            })
            if (u) {
                throw new Error("Candidate Already Registered with this email.")
            }
            // create the new user.
            const user = await db.candidate.create({
                data: {
                    name: name,
                    email: email,
                    phone: phone,
                    password: hashpass,
                    image_url: image_url,
                    gender: gender,
                    dob: moment(dob).toDate(),
                    country: country,
                    region: region,
                    full_address: full_address,
                    zip_code: zip_code,
                    private: private_val,
                    job_type: job_type,
                    work_experience: work_experience,
                    work_area_radius: work_area_radius,
                    working_hour_per_week: working_hour_per_week,
                    salary_per_hour: salary_per_hour,
                    salary_per_month: salary_per_month,
                    availability_date: availability_date,
                    work_shift: work_shift,
                    certificate: certificate,
                    other_certificate: other_certificate,
                    license: license,
                    it_skills: it_skills,
                    expected_benefits: expected_benefits,
                    current_employment: current_employment,
                    languages: {
                        connect: languages.map((item: number) => {
                            return {
                                id: item
                            }
                        })
                    },
                    job_profession: {
                        connect: {
                            id: job_profession_id
                        }
                    }
                }
            })

            //get token and set into cookie
            const token = Helper.getJWTtoken(user.id + "")
            //send token in http cookie with no expire
            res.cookie(Define.TOKEN, token, Define.SESSION_COOKIE_OPTION)

            //, token-if you want you can pass the token
            res.status(200).json(ApiResponse<candidate>(false, "user created successfully", user))

        } catch (e) {
            console.log("auth sign up: ", e);
            let response = ApiResponse(true, e.message, e);
            res.json(response);
        }
    },
    loginCandidate: async (req: Request, res: Response) => {
        try {

            const { email, password } = req.body
            //validatioin
            if (!email || !password) {
                throw new Error("Enter email,password")
            }
            //check user is available or not in db
            const u = await db.candidate.findUnique({
                where: {
                    email: email
                }
            })
            if (!u) {
                throw new Error("No User Found with this email!")
            }
            const user = u!

            //console.log(user);
            //validate password
            const ckPass = await bcryptjs.compare(password, user.password)
            if (!ckPass) {
                throw new Error("Wrong email or password")
            }

            //get token and set into cookie
            const token = Helper.getJWTtoken(user.id + "")
            //send token in http cookie with no expire
            res.cookie(Define.TOKEN, token, Define.SESSION_COOKIE_OPTION)

            //, token-if you want you can pass the token
            res.status(200).json(ApiResponse<candidate>(false, "user logged in successfully", user))

        } catch (e) {
            console.log("auth login: ", e);
            let response = ApiResponse(true, e.message, e);
            res.json(response);
        }
    },

}


export default CandidateController