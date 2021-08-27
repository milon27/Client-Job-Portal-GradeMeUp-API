import { Router, Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'

const router = Router()
const prisma = new PrismaClient()

router.get('/insert-post', async (req: Request, res: Response) => {
    const tag_id = 1
    try {
        // const post = await prisma.post.create({
        //     data: {
        //         title: "first post",
        //         post_tag: {
        //             connect: {
        //                 tid: 1
        //             }
        //         }
        //     }
        // })
        // res.send(post)


        // const posts = await prisma.tag.findMany({
        //     include: {
        //         post_tag: true
        //     }
        // })
        // res.send(posts)

        //filter all post where every post has tag id=2
        const posts = await prisma.post.findMany({
            include: {
                tags: true
            },
            where: {
                tags: {
                    some: {
                        tid: 2
                    }
                }
            }
        })
        res.send(posts)


    } catch (error) {
        console.log("err", error.message);

        res.send(error)
    }

})


export default router