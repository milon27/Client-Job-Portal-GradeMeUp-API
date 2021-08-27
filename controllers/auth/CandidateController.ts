import { Request, Response } from "express";
import { PrismaClient, Admin, Language } from "@prisma/client";
import ApiResponse from '../../models/ApiResponse';
import Define from "../../utils/Define";
import Helper from "../../utils/Helper";
import bcryptjs from 'bcryptjs'


const db = new PrismaClient()


const CandidateController = {
    /**
     * @description
     * get email, name, password from req.body
     * do validatioin
     * ck already have an account or not(mySql Optional,Mongo required)
     * create password hash,save into database
     * generate a jwt access token,set into http cookie
     * return new user object as response
    * @param { email, name, password, type } =req.body
     * @response {error(boolean), message(String), response(object:USER)}
     */
    signUpCandidate: async (req: Request, res: Response) => {






        // try {
        //     const candidate = req.body
        //     //validatioin handle by sequlize

        //     if (candidate.password.length < 6) {
        //         throw new Error("Password Length Should be More than 5 character.")
        //     }
        //     //get hash pass & save new user into db
        //     const hashpass = await bcryptjs.hash(candidate.password, await bcryptjs.genSalt(10))

        //     //save on database

        //     const u = await db.candidate.findUnique({
        //         where: {
        //             email: candidate.email
        //         }
        //     })
        //     if (u) {
        //         throw new Error("Candidate Already Registered with this email.")
        //     }
        //     //create the new user.
        //     const user = await db.candidate.create({
        //         data: {
        //             name: "",
        //             languages:
        //             {
        //                 connect: [
        //                     {
        //                         candidate_id_language_id: {
        //                             candidate_id: id
        //                             language_id: 1
        //                         }
        //                     }
        //                 ]
        //             }

        //         }
        //     })

        //     //get token and set into cookie
        //     const token = Helper.getJWTtoken(user.id + "")
        //     //send token in http cookie with no expire
        //     res.cookie(Define.TOKEN, token, Define.SESSION_COOKIE_OPTION)

        //     //, token-if you want you can pass the token
        //     res.status(200).json(ApiResponse<Admin>(false, "user created successfully", user))

        // } catch (e) {
        //     console.log("auth sign up: ", e);
        //     let response = ApiResponse(true, e.message, e);
        //     res.json(response);
        // }
    },
    loginCandidate: async (req: Request, res: Response) => {
        try {

            const { email, password } = req.body
            //validatioin
            if (!email || !password) {
                throw new Error("Enter email,password")
            }
            //check user is available or not in db
            const u = await db.admin.findUnique({
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
            res.status(200).json(ApiResponse<Admin>(false, "user logged in successfully", user))

        } catch (e) {
            console.log("auth login: ", e);
            let response = ApiResponse(true, e.message, e);
            res.json(response);
        }
    },

}


export default CandidateController