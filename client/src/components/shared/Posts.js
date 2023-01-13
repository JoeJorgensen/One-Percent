import axios from "axios"
import { useEffect } from "react"
import { useState } from "react"
import { useContext } from "react"
import Badge from "react-bootstrap/esm/Badge"
import { Link, useNavigate } from "react-router-dom"
import { AuthContext } from "../../providers/AuthProvider"
import Card from "../Card"
import ContentCard from "./ContentCard"
import PostCard from "./PostCard"

const Posts = ()=>{
  


    const [posts, setPosts] = useState([])
    const navigate = useNavigate()



    useEffect(() => {
        getPosts();
      }, []);
    
      const getPosts = async () => {
        try {
          let res = await axios.get("/api/posts");
          setPosts(res.data);
        } catch (error) {
          alert("error occurred getting campaign data");
        }
    
      };

      function styledCards() {
        return (
    
          <>
              {posts.map((p) => (
                <PostCard
                  onClick={ () => navigate(`/post_show/${p.id}`)}
                  key={p.id}
                  title={p.name}
                  description={p.description}
                  image={p.image }
                  
                />
              ))}
    
    
          </>
    
        );
      }
    






    return (
        <ContentCard>
        <div>
           {styledCards()}

        </div>
        </ContentCard>
    )
} 
export default Posts